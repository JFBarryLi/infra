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

variable "log_bucket_name" {
  type        = string
  description = "Log bucket name."
}

variable "targets" {
  type = map(object({
    domain = string
    port   = number
  }))
  description = "Targets for the alb."
}
