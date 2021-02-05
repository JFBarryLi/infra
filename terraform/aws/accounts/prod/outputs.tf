output "barryli_name_servers" {
  description = "Nameservers of the created zone."
  value       = module.barryli_ca.name_servers
}
