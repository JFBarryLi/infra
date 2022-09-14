variable "lb_enabled" {
  type        = bool
  description = "Flag to enable/disable the lb"
}

variable "environment" {
  type        = string
  description = "Environment name."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids."
}

variable "vpc_id" {
  type        = string
  description = "vpc_id."
}

variable "zone_id" {
  type        = string
  description = "Zone id."
}

variable "targets" {
  type = map(object({
    domain = string
    port   = number
  }))
  description = "Targets for the alb."
}

variable "log_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write logs to."
}
