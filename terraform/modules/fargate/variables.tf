variable "task_name" {
  type        = string
  description = "Fargate name."
}

variable "environment" {
  type        = string
  description = "Environment name for the task."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "Ecs cluster arn."
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
