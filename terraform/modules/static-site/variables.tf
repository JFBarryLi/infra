variable "domain_name" {
  type        = string
  description = "The primary domain name for the distribution."
}

variable "zone_id" {
  type        = string
  description = "Zone id of the created zone for the domain."
}

variable "log_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write logs to."
}

variable "log_bucket_domain" {
  type        = string
  description = "The domain of the S3 bucket to write logs to."
}
