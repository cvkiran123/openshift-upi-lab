# Identity Variables
variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI User OCID"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID of the OCI compartment where resources are created."
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
}

# Authentication Variables
variable "fingerprint" {
  description = "OCI API Key Fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to the OCI private key"
  type        = string
}

# Region Variables
variable "region" {
  description = "OCI Region"
  type        = string
}

variable "vcn_name" {
  description = "Name of the VCN"
  type        = string
}
variable "vcn_dns_label" {
  description = "DNS label for the VCN"
  type        = string
}
variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}
variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
}
variable "security_list_name" {
  description = "Name of the Security List"
  type        = string
}

variable "public_subnet_name" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "public_subnet_dns" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "private_subnet_dns" {
  type = string
}

variable "load_balancer_name" {
  type = string
}

variable "load_balancer_shape" {
  type = string
}

variable "lb_min_bandwidth" {
  type = number
}

variable "lb_max_bandwidth" {
  type = number
}

# Backend Set Variables
variable "api_backend_set_name" {
  type = string
}

# Listener Variables
variable "api_listener_name" {
  type = string
}
# Machine Config Server Backend Set
variable "mcs_backend_set_name" {
  description = "Name of the Machine Config Server backend set"
  type        = string
}
# Machine Config Server Listener
variable "mcs_listener_name" {
  description = "Name of the Machine Config Server listener"
  type        = string
}


# Compute Instance Variables
variable "availability_domain" {
  type = string
}

variable "bootstrap_name" {
  type = string
}

variable "instance_shape" {
  type = string
}

variable "coreos_image_ocid" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "bootstrap_hostname" {
  type = string
}

# Map of node configurations
variable "nodes" {
  type = map(object({
    shape            = string
    ocpus            = number
    memory_in_gbs    = number
    assign_public_ip = bool
    hostname_label   = string
  }))
}

# DNS Variables

variable "zone_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "resolver_id" {
  type = string
}

variable "image_object_name" {
  type = string
}

# Custom Image Variables
variable "local_image_path" {
  type = string
}

# Ignition Variables
variable "bootstrap_ignition_path" {
  description = "Path to the OKD bootstrap Ignition configuration"
  type        = string
}

variable "master_ignition_path" {
  description = "Path to the OKD master Ignition configuration"
  type        = string
}

variable "worker_ignition_path" {
  description = "Path to the OKD worker Ignition configuration"
  type        = string
}

variable "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  type        = string
}