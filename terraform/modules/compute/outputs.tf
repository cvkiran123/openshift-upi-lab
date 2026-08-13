output "instance_ids" {
  description = "OCIDs of all compute instances"
  value = {
    for name, instance in oci_core_instance.compute :
    name => instance.id
  }
}

output "private_ips" {
  description = "Private IP addresses of all compute instances"
  value = {
    for name, instance in oci_core_instance.compute :
    name => instance.private_ip
  }
}

output "display_names" {
  description = "Display names of all compute instances"
  value = {
    for name, instance in oci_core_instance.compute :
    name => instance.display_name
  }
}