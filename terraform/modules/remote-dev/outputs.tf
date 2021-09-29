output "public_ip" {
  description = "Public ip address of the remote dev machine."
  value       = var.ec2_on ? aws_instance.this[0].public_ip : null
}
