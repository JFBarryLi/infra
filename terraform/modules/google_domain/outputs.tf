output "zone_id" {
  description = "Created Zone Id."
  value       = aws_route53_zone.zone.id
}

output "name_servers" {
  description = "Nameservers of the created zone."
  value       = aws_route53_zone.zone.name_servers
}
