output "compute_instances" {
  value = module.compute.instance_ids
}

output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}

/*
output "bootstrap_private_ip" {
  value = module.bootstrap.bootstrap_private_ip
}

output "bootstrap_instance_id" {
  value = module.bootstrap.bootstrap_instance_id
}
*/
output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = module.compute.bastion_private_ip
}

output "private_ips" {
  value = module.compute.private_ips
}

output "load_balancer_ip" {
  description = "Public IP address of the OCI Load Balancer"
  value       = module.loadbalancer.load_balancer_ip
}