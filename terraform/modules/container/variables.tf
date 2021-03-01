variable "repo_name" {
  type        = string
  description = "Repository name."
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet ids to launch resources in."
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name for the ECS Cluster."
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for ecs placements."
}
