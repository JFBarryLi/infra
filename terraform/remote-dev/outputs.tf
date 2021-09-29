output "public_ip" {
  description = "Public ip address of the remote dev machine."
  value       = module.rd.public_ip
}
