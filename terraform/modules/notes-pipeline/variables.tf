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
