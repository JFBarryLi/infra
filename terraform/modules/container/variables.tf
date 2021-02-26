variable "repo_name" {
  type        = string
  description = "Repository name."
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
}

variable "subnet_id" {
  type        = string
  description = "Subnet id for the ecs cluster to be in."
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name for the ECS Cluster."
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for ecs placements."
}
