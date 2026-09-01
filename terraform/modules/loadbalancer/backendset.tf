resource "oci_load_balancer_backend_set" "api_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  name             = var.api_backend_set_name
  policy           = "ROUND_ROBIN"
  health_checker {
    protocol = "TCP"
    port     = 6443
  }
}

resource "oci_load_balancer_backend_set" "mcs_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  name             = var.mcs_backend_set_name
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol = "TCP"
    port     = 22623
  }
}

# Ingress HTTP backend set
resource "oci_load_balancer_backend_set" "http_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  name             = "okd-http-backend-set"
  policy           = "IP_HASH"

  health_checker {
    protocol = "TCP"
    port     = 80
    url_path = "/"
    return_code = 503
  }
}

# Ingress HTTPS backend set
resource "oci_load_balancer_backend_set" "https_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  name             = "okd-https-backend-set"
  policy           = "IP_HASH"

  health_checker {
    protocol = "TCP"
    port     = 443
    url_path = "/"
    return_code = 503
  }
}