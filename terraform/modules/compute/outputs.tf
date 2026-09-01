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

output "bastion_public_ip" {
  value = oci_core_instance.compute["bastion"].public_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = oci_core_instance.compute["bastion"].private_ip
}

output "display_names" {
  description = "Display names of all compute instances"
  value = {
    for name, instance in oci_core_instance.compute :
    name => instance.display_name
  }
}