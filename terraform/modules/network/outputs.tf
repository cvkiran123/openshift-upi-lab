output "vcn_id" {
  description = "VCN ID"
  value       = oci_core_vcn.okd_platform.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = oci_core_subnet.okd_public_subnet.id
}

output "security_list_id" {
  description = "Public Security List ID"
  value       = oci_core_security_list.okd_public_sl.id
}

output "route_table_id" {
  description = "Public Route Table ID"
  value       = oci_core_route_table.okd_public_rt.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = oci_core_internet_gateway.okd_igw.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = oci_core_subnet.okd_private_subnet.id
}