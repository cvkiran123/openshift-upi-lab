variable "load_balancer_name" {
  description = "Name of the Load Balancer"
  type        = string
}
variable "load_balancer_shape" {
  description = "Shape of the Load Balancer"
  type        = string
}

variable "lb_min_bandwidth" {
  description = "Minimum bandwidth for the Load Balancer"
  type        = number
}
variable "lb_max_bandwidth" {
  description = "Maximum bandwidth for the Load Balancer"
  type        = number
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

# Machine Config Server Backends
variable "mcs_backends" {
  description = "Map of Machine Config Server backend IP addresses"
  type        = map(string)
}

# HTTP Backend Set
variable "worker_ips" {
  description = "Private IP addresses of OpenShift worker nodes"
  type        = map(string)
}