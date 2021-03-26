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

variable "max_size" {
  type        = number
  description = "Max number of instances."
  default     = 1
}

variable "max_step_size" {
  type        = number
  description = "Max scaling step adjustment size."
  default     = 1
}

variable "min_step_size" {
  type        = number
  description = "Min scaling step adjustment size."
  default     = 1
}

variable "domain_name" {
  type        = string
  description = "Domain name for the service."
}

variable "zone_id" {
  type        = string
  description = "Zone id of the created zone for the domain."
}

variable "log_bucket_domain" {
  type        = string
  description = "The name of the s3 bucket to write logs to."
}
