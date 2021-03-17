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

variable "container_name" {
  type        = string
  description = "Container name."
}

variable "container_port" {
  type        = number
  description = "Container port."
  default     = 80
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for ecs placements."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type to use."
  default     = "t2.micro"
}

variable "desired_capacity" {
  type        = string
  description = "Desired number of instances."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Max number of instances."
  default     = 1
}

variable "min_size" {
  type        = number
  description = "Min number of instances."
  default     = 1
}

variable "api_stage_name" {
  type        = string
  description = "Deployment api stage name."
  default     = "dev"
}
