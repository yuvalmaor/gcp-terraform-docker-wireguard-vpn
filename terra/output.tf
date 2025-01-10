
output "vm_ip" {
  sensitive = false
  value = module.compute.vm_ip
}
