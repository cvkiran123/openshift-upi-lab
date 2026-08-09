variable "compartment_ocid" {
  description = "OCID of the OCI compartment where network resources are created."
  type        = string
}
variable "vcn_cidr" {
  description = "CIDR block for the VCN."
  type        = string
}
variable "vcn_name" {
  description = "Name of the VCN."
  type        = string
}
variable "vcn_dns_label" {
  description = "DNS label for the VCN."
  type        = string
}
variable "igw_name" {
  description = "Name of the Internet Gateway."
  type        = string
}
variable "route_table_name" {
  description = "Name of the Route Table."
  type        = string
}
variable "security_list_name" {
  description = "Name of the Security List."
  type        = string
}
variable "public_subnet_name" {
  description = "Name of the public subnet."
  type        = string
}
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}
variable "public_subnet_dns" {
  description = "DNS label for the public subnet."
  type        = string
}