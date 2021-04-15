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
