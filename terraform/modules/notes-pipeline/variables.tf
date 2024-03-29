variable "pipeline_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store pipeline objects."
}

variable "log_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write logs to."
}

variable "environment" {
  type        = string
  description = "Environment name."
}

variable "domain_name" {
  type        = string
  description = "API domain name."
}

variable "task_name" {
  type        = string
  description = "Name of the task."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "Ecs cluster arn."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet ids to launch resources in."
}

variable "vpc_id" {
  type        = string
  description = "Vpc id."
}
