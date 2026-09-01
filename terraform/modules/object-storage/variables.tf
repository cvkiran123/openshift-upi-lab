variable "compartment_id" {
  type = string
}

variable "bucket_name" {
  type    = string
  default = "okd-images"
}

variable "object_name" {
  type = string
}

variable "local_image_path" {
  type = string
}