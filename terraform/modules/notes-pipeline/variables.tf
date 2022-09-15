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

variable "service_name" {
  type        = string
  description = "Name of the service."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "Ecs cluster arn."
}
