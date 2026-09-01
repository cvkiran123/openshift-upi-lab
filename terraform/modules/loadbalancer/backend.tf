resource "oci_load_balancer_backend" "api_backends" {
  for_each = var.api_backends

  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.api_backend_set.name

  ip_address = each.value
  port       = 6443
  weight     = 1
}

resource "oci_load_balancer_backend" "mcs_backends" {
  for_each = var.mcs_backends

  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.mcs_backend_set.name

  ip_address = each.value
  port       = 22623
  weight     = 1
}


resource "oci_load_balancer_backend" "http_backends" {
  for_each = var.worker_ips

  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.http_backend_set.name

  ip_address = each.value
  port       = 80
  weight     = 1
}

resource "oci_load_balancer_backend" "https_backends" {
  for_each = var.worker_ips

  load_balancer_id = oci_load_balancer_load_balancer.okd_load_balancer.id
  backendset_name  = oci_load_balancer_backend_set.https_backend_set.name

  ip_address = each.value
  port       = 443
  weight     = 1
}