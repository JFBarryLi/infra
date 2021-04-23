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

variable "task_desired_count" {
  type        = number
  description = "Desired number of tasks."
}

variable "task_max_percent" {
  type        = number
  description = "Maximum percent healthy for the task."
}

variable "task_min_percent" {
  type        = number
  description = "Minimum percent healthy for the task."
}

variable "target_group_arn" {
  type        = string
  description = "Load balancer target group arn."
}

variable "lb_container_name" {
  type        = string
  description = "Container name for the alb to connect to."
}

variable "lb_container_port" {
  type        = number
  description = "Container port for the alb to connect to."
}

variable "repo_names" {
  type = map(object({
    name = string
  }))
  description = "Repository names."
}
