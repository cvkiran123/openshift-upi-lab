module "network" {
  source = "./modules/network"
  # VCN
  compartment_ocid = var.compartment_ocid
  vcn_cidr         = var.vcn_cidr
  vcn_name         = var.vcn_name
  vcn_dns_label    = var.vcn_dns_label
  # Internet Gateway
  igw_name = var.igw_name
  # Route Table
  route_table_name = var.route_table_name
  # Security List
  security_list_name = var.security_list_name
  # Public Subnet
  public_subnet_name = var.public_subnet_name
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_dns  = var.public_subnet_dns
}

# Load Balancer
module "loadbalancer" {
  source = "./modules/loadbalancer"

  subnet_id           = module.network.public_subnet_id
  load_balancer_name  = var.load_balancer_name
  load_balancer_shape = var.load_balancer_shape
  compartment_ocid    = var.compartment_ocid

  # Backend Set
  api_backend_set_name = var.api_backend_set_name

  # Listener
  api_listener_name = var.api_listener_name

  # Backend IPs
  api_backends = {
    master-1 = module.compute.private_ips["master-1"]
    master-2 = module.compute.private_ips["master-2"]
    master-3 = module.compute.private_ips["master-3"]
  }
}



# Compute Instance
module "compute" {

  source = "./modules/compute"

  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  coreos_image_ocid   = var.coreos_image_ocid
  subnet_id           = module.network.public_subnet_id

  ssh_public_key = var.ssh_public_key

  nodes = var.nodes
}

# DNS Zone
module "dns" {
  source = "./modules/dns"

  compartment_ocid = var.compartment_ocid

  zone_name    = var.zone_name
  cluster_name = var.cluster_name

  load_balancer_ip = module.loadbalancer.load_balancer_ip
  vcn_id           = module.network.vcn_id
  resolver_id      = var.resolver_id
}