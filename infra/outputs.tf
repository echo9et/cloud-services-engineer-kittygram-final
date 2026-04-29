output "vm_name" {
  description = "Name of created VM"
  value       = yandex_compute_instance.vm_1.name
}

output "vm_public_ip" {
  description = "Public IP address of created VM"
  value       = yandex_compute_instance.vm_1.network_interface.0.nat_ip_address
}

output "vm_username" {
  description = "Username of created VM"
  value       = var.vm_user
}
