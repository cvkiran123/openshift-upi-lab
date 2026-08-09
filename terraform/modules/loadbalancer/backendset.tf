resource "oci_load_balancer_backend_set" "api_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  name             = var.api_backend_set_name
  policy           = "ROUND_ROBIN"
  health_checker {
    protocol = "TCP"
    port     = 6443
  }
}
