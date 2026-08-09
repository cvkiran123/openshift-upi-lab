variable "compartment_ocid" {
  type = string
}
variable "availability_domain" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "instance_shape" {
  type = string
}

variable "coreos_image_ocid" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "assign_public_ip" {
  type = bool
}

variable "hostname_label" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
