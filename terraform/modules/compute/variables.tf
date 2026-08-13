variable "compartment_ocid" {
  type = string
}
variable "availability_domain" {
  type = string
}


variable "coreos_image_ocid" {
  type = string
}

variable "subnet_id" {
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


