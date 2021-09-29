variable "ec2_on" {
  type        = string
  default     = "0"
  description = "On/off flag for thhe ec2 instance."
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type."
}

variable "key_name" {
  type        = string
  description = "ec2 key name."
}
