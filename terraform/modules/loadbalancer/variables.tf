variable "load_balancer_name" {
  description = "Name of the Load Balancer"
  type        = string
}
variable "load_balancer_shape" {
  description = "Shape of the Load Balancer"
  type        = string
}
variable "subnet_id" {
  description = "OCID of the subnet where the Load Balancer will be created."
  type        = string
}
variable "compartment_ocid" {
  description = "OCID of the compartment where the Load Balancer will be created."
  type        = string
}

#Backend Set Variables
variable "api_backend_set_name" {
  description = "Name of the API Backend Set"
  type        = string
}

# Listener Variables
variable "api_listener_name" {
  description = "Name of the API Listener"
  type        = string
}

# Backend Variables
variable "api_backends" {
  description = "Map of API Backend IP addresses"
  type        = map(string)
}