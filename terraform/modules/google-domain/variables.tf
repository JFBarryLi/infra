variable "domain" {
  type        = string
  description = "The domain to create the zone for."
}

variable "email_forwarding" {
  type        = string
  description = "Setup MX records for email forwarding."
  default     = false
}
