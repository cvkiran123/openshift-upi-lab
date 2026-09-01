variable "compartment_ocid" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "object_storage_namespace" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "object_name" {
  type = string
}

variable "display_name" {
  type    = string
  default = "okd-custom-image"
}

variable "region" {
  type = string
}

variable "nodes" {
  type = map(object({
    shape            = string
    ocpus            = number
    memory_in_gbs    = number
    assign_public_ip = bool
    hostname_label   = string
  }))
}