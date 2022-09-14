output "target_groups" {
  description = "Map of lb target group arn."
  value       = var.lb_enabled == true ? { for k, v in aws_lb_target_group.this : k => v.arn } : {}
}

output "endpoints" {
  description = "Map of the endpoints."
  value       = var.lb_enabled == true ? { for k, v in aws_route53_record.alias : k => v.name } : {}
}

output "lb_security_group_id" {
  description = "Lb security group id."
  value       = aws_security_group.alb.id
}
