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

variable "lb_enabled" {
  type        = bool
  default     = false
  description = "Flag to determine whether or not to use a load balancer."
}

variable "target_groups" {
  default = []
  type = list(
    object({
      container_name   = string
      container_port   = number
      target_group_arn = string
      }
    )
  )
  description = "List of target groups, with their respective container name, port and target group arn."
}

variable "repo_names" {
  type = map(object({
    name = string
  }))
  description = "Repository names."
}
