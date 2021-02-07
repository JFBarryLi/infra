output "barryli_name_servers" {
  description = "Nameservers of the created zone."
  value       = module.barryli_ca.name_servers
}

output "deployer_access_key_id" {
  description = "The AWS access key id that can deploy to the site."
  value       = module.fea_site.deployer_access_key_id
}

output "deployer_secret_access_key" {
  description = "The AWS secret access key that can deploy to the site."
  value       = module.fea_site.deployer_secret_access_key
  sensitive   = true
}

output "fea_cf_distribution_id" {
  description = "Fea cloudfront distribution_id."
  value       = module.fea_site.distribution_id
  sensitive   = true
}
