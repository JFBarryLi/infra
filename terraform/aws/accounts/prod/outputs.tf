output "barryli_name_servers" {
  description = "Nameservers of the created zone."
  value       = module.barryli_ca.name_servers
}

output "site_fea_deployer_access_key_id" {
  description = "The AWS access key id that can deploy to the site."
  value       = module.fea_site.deployer_access_key_id
}

output "site_fea_deployer_secret_access_key" {
  description = "The AWS secret access key that can deploy to the site."
  value       = module.fea_site.deployer_secret_access_key
  sensitive   = true
}

output "site_fea_cf_distribution_id" {
  description = "Fea cloudfront distribution_id."
  value       = module.fea_site.distribution_id
  sensitive   = true
}

output "site_fea_bucket_name" {
  description = "Fea site bucket name."
  value       = module.fea_site.bucket_name
}

output "site_fea_bucket_region" {
  description = "Fea site bucket region/"
  value       = module.fea_site.bucket_region
}

output "repository_url" {
  description = "Ecr repo url."
  value       = module.fea_container.repository_url
}

output "api_fea_domain_name" {
  description = "Fea api service domain name."
  value       = module.fea_container.domain_name
}
