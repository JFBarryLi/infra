variable "service_name" {
  type        = string
  description = "Service name."
}

variable "environment" {
  type        = string
  description = "Environment name for the service."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "Ecs cluster arn."
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
}

variable subnet_ids {
  type        = list(string)
  description = "List of subnets."
}

variable "desired_task_count" {
  type        = number
  description = "Desired number of tasks."
}

variable "lb_security_group_id" {
  type        = string
  description = "Load balancer security group id."
}

variable "target_group_arn" {
  type        = string
  description = "Load balancer target group arn."
}

variable "container_port" {
  type        = number
  description = "Container port."
}

variable "repo_names" {
  type        = list(string)
  description = "Repository names."
}

variable "service_endpoint" {
  type        = string
  description = "Domain name for the service."
}

variable "zone_id" {
  type        = string
  description = "Zone id of the created zone for the service endpoint."
}

variable "log_bucket_domain" {
  type        = string
  description = "The name of the s3 bucket to write logs to."
}
