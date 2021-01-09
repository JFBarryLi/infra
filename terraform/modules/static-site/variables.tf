variable "domain_name" {
  type        = string
  description = "The primary domain name for the distribution."
}

variable "bucket_logs_domain" {
  type        = string
  description = "The domain of the S3 bucket to write logs to"
}
