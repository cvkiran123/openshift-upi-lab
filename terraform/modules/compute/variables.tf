variable "compartment_ocid" {
  type = string
}
variable "availability_domain" {
  type = string
}


variable "coreos_image_ocid" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}


variable "ssh_public_key" {
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

# Ignition Configurations
variable "master_ignition_path" {
  type = string
}

variable "worker_ignition_path" {
  type = string
}

variable "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  type        = string
}