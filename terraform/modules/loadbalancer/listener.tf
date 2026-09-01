resource "oci_load_balancer_listener" "api_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.okd_load_balancer.id
  name                     = var.api_listener_name
  default_backend_set_name = oci_load_balancer_backend_set.api_backend_set.name
  protocol                 = "TCP"
  port                     = 6443
}


# Machine Config Server Listener
resource "oci_load_balancer_listener" "mcs_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.okd_load_balancer.id
  name                     = var.mcs_listener_name
  default_backend_set_name = oci_load_balancer_backend_set.mcs_backend_set.name
  protocol                 = "TCP"
  port                     = 22623
}

# HTTP
resource "oci_load_balancer_listener" "http_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.okd_load_balancer.id
  name                     = "okd-http-listener"
  default_backend_set_name = oci_load_balancer_backend_set.http_backend_set.name

  protocol = "TCP"
  port     = 80
}

# HTTPS
resource "oci_load_balancer_listener" "https_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.okd_load_balancer.id
  name                     = "okd-https-listener"
  default_backend_set_name = oci_load_balancer_backend_set.https_backend_set.name

  protocol = "TCP"
  port     = 443
}
