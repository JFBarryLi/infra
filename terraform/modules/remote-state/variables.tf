variable "state_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write the state to."
}

variable "log_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to write logs to."
}

variable "create_lock_table" {
  type        = bool
  description = "Whether or not to create a Dynamo DB lock table"
  default     = false
}
