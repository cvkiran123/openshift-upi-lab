output "load_balancer_id" {
  value = oci_load_balancer_load_balancer.okd_load_balancer.id
}


output "load_balancer_ip" {
  value = oci_load_balancer_load_balancer.okd_load_balancer.ip_address_details[0].ip_address
}