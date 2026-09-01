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
  # Private Subnet
  private_subnet_name = var.private_subnet_name
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_dns  = var.private_subnet_dns
}

# Load Balancer
module "loadbalancer" {
  source = "./modules/loadbalancer"

  subnet_id           = module.network.public_subnet_id
  load_balancer_name  = var.load_balancer_name
  load_balancer_shape = var.load_balancer_shape
  compartment_ocid    = var.compartment_ocid
  #shape_details = var.shape_details
  lb_min_bandwidth = var.lb_min_bandwidth
  lb_max_bandwidth = var.lb_max_bandwidth

  # API : 6443 Backend Set & Listener
  api_backend_set_name = var.api_backend_set_name
  api_listener_name    = var.api_listener_name

  # API Backend IPs
  api_backends = {
    master-1 = module.compute.private_ips["master-1"]
    master-2 = module.compute.private_ips["master-2"]
    master-3 = module.compute.private_ips["master-3"]
    #bootstrap = module.bootstrap.bootstrap_private_ip
  }

  ## MCS :22623
  mcs_backend_set_name = var.mcs_backend_set_name
  mcs_listener_name    = var.mcs_listener_name

  mcs_backends = {
    #bootstrap = module.bootstrap.bootstrap_private_ip
    master-1 = module.compute.private_ips["master-1"]
    master-2 = module.compute.private_ips["master-2"]
    master-3 = module.compute.private_ips["master-3"]
  }

  worker_ips = {
    for name, ip in module.compute.private_ips :
    name => ip
    if startswith(name, "worker-")
  }
}



# Compute Instance
module "compute" {

  source = "./modules/compute"

  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  coreos_image_ocid   = module.custom_image.image_id
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id
  ssh_public_key      = var.ssh_public_key
  nodes               = var.nodes

  master_ignition_path = var.master_ignition_path
  worker_ignition_path = var.worker_ignition_path
  bastion_private_ip   = var.bastion_private_ip
}

/*
# Bootstrap Instance
module "bootstrap" {
  source = "./modules/bootstrap"

  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  coreos_image_ocid   = module.custom_image.image_id
  private_subnet_id   = module.network.private_subnet_id
  ssh_public_key      = var.ssh_public_key

  bootstrap_ignition_path = var.bootstrap_ignition_path

  bastion_private_ip = module.compute.private_ips["bastion"]
}
*/
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

# Object Storage
module "object_storage" {
  source           = "./modules/object-storage"
  compartment_id   = var.compartment_ocid
  bucket_name      = "okd-images"
  object_name      = var.image_object_name
  local_image_path = var.local_image_path
}

# Custom Image
module "custom_image" {
  source = "./modules/custom-image"

  compartment_ocid         = var.compartment_ocid
  availability_domain      = var.availability_domain
  region                   = var.region
  object_storage_namespace = module.object_storage.namespace
  bucket_name              = module.object_storage.bucket_name
  object_name              = var.image_object_name
  display_name             = "okd-custom-image"
  nodes                    = var.nodes
}