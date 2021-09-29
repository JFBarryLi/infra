variable "ec2_on" {
  type        = string
  description = "On/off flag for thhe ec2 instance."
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type."
}

variable "region" {
  type        = string
  description = "AWS region."
}
