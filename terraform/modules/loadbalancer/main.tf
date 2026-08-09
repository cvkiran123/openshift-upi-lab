resource "oci_load_balancer_load_balancer" "okd_load_balancer" {
  compartment_id = var.compartment_ocid
  display_name   = var.load_balancer_name
  shape          = var.load_balancer_shape
  subnet_ids     = [var.subnet_id]
}