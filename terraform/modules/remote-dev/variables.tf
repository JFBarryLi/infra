variable "ec2_on" {
  type        = string
  default     = "0"
  description = "On/off flag for thhe ec2 instance."
}

variable "ami" {
  type        = string
  description = "ami for the ec2 instance."
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type"
}
