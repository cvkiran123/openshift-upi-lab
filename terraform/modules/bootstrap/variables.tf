variable "compartment_ocid" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "coreos_image_ocid" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

# Ignition Configurations
variable "bootstrap_ignition_path" {
  type = string
}

# bastion_private_ip variable to hold the private IP of the bastion host
variable "bastion_private_ip" {
  type = string
}