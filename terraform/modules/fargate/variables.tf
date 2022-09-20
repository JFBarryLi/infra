variable "service_name" {
  type        = string
  description = "Fargate name."
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

variable "repo_names" {
  type = map(object({
    name = string
  }))
  description = "Repository names."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet ids to launch resources in."
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
}
