resource "oci_load_balancer_backend" "api_backends" {
  for_each = var.api_backends

  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.api_backend_set.name

  ip_address = each.value
  port       = 6443
  weight     = 1
}