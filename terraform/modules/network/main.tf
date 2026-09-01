# Virtual Cloud Network
resource "oci_core_vcn" "okd_platform" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = [var.vcn_cidr]
  display_name   = var.vcn_name
  dns_label      = var.vcn_dns_label
}

# Internet Gateway
resource "oci_core_internet_gateway" "okd_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.okd_platform.id
  display_name   = var.igw_name
  enabled        = true
}

# Route Table
resource "oci_core_route_table" "okd_public_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.okd_platform.id
  display_name   = var.route_table_name
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.okd_igw.id
  }
}
# Security List
resource "oci_core_security_list" "okd_public_sl" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.okd_platform.id
  display_name   = var.security_list_name
  dynamic "ingress_security_rules" {
    for_each = local.public_tcp_ports
    content {
      protocol    = "6"
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = false
      description = "Allow TCP ${ingress_security_rules.value}"
      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }
  ingress_security_rules {
    protocol    = "all"
    source      = var.vcn_cidr
    stateless   = false
    description = "Internal OKD Communication"
  }
  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    stateless        = false
    destination_type = "CIDR_BLOCK"
    description      = "Outbound Internet"
  }
}

# Public Subnet
resource "oci_core_subnet" "okd_public_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.okd_platform.id
  cidr_block                 = var.public_subnet_cidr
  display_name               = var.public_subnet_name
  dns_label                  = var.public_subnet_dns
  route_table_id             = oci_core_route_table.okd_public_rt.id
  security_list_ids          = [oci_core_security_list.okd_public_sl.id]
  prohibit_public_ip_on_vnic = false
  dhcp_options_id            = oci_core_vcn.okd_platform.default_dhcp_options_id
}

# Private Subnet
resource "oci_core_subnet" "okd_private_subnet" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.okd_platform.id
  cidr_block                 = var.private_subnet_cidr
  display_name               = var.private_subnet_name
  dns_label                  = var.private_subnet_dns
  route_table_id             = oci_core_route_table.okd_private_rt.id
  security_list_ids          = [oci_core_security_list.okd_public_sl.id]
  prohibit_public_ip_on_vnic = true
  dhcp_options_id            = oci_core_vcn.okd_platform.default_dhcp_options_id
}

# Nat Gateway
resource "oci_core_nat_gateway" "okd_nat" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.okd_platform.id
  display_name   = "okd-nat"
  block_traffic  = false
}

# Private Route Table
resource "oci_core_route_table" "okd_private_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.okd_platform.id
  display_name   = "okd-private-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.okd_nat.id
  }
}