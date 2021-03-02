variable "azs" {
  type        = list(string)
  description = "Availability Zones for subnets."
}

variable "vpc_cidr_block" {
  type        = string
  description = "Cidr block for the vpc."
}
