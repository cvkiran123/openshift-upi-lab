resource "oci_load_balancer_listener" "api_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.okd_load_balancer.id
  name                     = var.api_listener_name
  default_backend_set_name = oci_load_balancer_backend_set.api_backend_set.name
  protocol                 = "TCP"
  port                     = 6443
}