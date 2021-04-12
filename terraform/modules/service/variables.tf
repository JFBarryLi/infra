variable "service_name" {
  type        = string
  description = "Service name."
}

variable "ecs_cluster_id" {
  type        = string
  description = "Ecs cluster id."
}

variable "repo_names" {
  type        = list(string)
  description = "Repository names."
}

variable "service_endpoint" {
  type        = string
  description = "Domain name for the service."
}

variable "zone_id" {
  type        = string
  description = "Zone id of the created zone for the service endpoint."
}

variable "log_bucket_domain" {
  type        = string
  description = "The name of the s3 bucket to write logs to."
}
