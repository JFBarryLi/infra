output "target_groups" {
  description = "Map of lb target group arn."
  value       = { for k, v in aws_lb_target_group.this: k => v.arn }
}

output "lb_security_group" {
  description = "Lb security group id."
  value = aws_security_group.alb.id
}
