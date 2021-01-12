variable "domain_name" {
  type        = string
  description = "The primary domain name for the distribution."
}

variable "log_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write logs to."
}
