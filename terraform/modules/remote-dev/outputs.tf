output "public_ip" {
  description = "Public ip address of the remote dev machine."
  value       = aws_instance.this.public_ip
}
