output "instance_id" {
  value = oci_core_instance.compute.id
}

output "private_ip" {
  value = oci_core_instance.compute.private_ip
}

output "display_name" {
  value = oci_core_instance.compute.display_name
}