output "aws_region" {
  description = "Aws region."
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "Aws account id."
  value       = data.aws_caller_identity.current.account_id
}

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
  description = "Fea site bucket region."
  value       = module.fea_site.bucket_region
}

output "repository_urls" {
  description = "Ecr repo urls."
  value       = module.fea_service.repository_urls
}

output "api_fea_service_endpoint" {
  description = "Fea api service domain name."
  value       = local.lb_enabled == true ? module.alb.endpoints["api_fea"] : null
}

output "fea_service_deployer_access_key_id" {
  description = "The AWS access key id for the fea service deployer."
  value       = module.fea_service.service_deployer_access_key_id
}

output "fea_service_deployer_secret_access_key" {
  description = "The AWS secret access key for the fea service deployer."
  value       = module.fea_service.service_deployer_secret_access_key
  sensitive   = true
}

output "fea_service_task_role_arn" {
  description = "Fea service default task IAM role arn."
  value       = module.fea_service.task_role_arn
}

output "fea_service_awslogs_group_name" {
  description = "Fea service awslogs group name."
  value       = module.fea_service.awslogs_group_name
}

output "site_barryli_deployer_access_key_id" {
  description = "The AWS access key id that can deploy to the site."
  value       = module.barryli_site.deployer_access_key_id
}

output "site_barryli_deployer_secret_access_key" {
  description = "The AWS secret access key that can deploy to the site."
  value       = module.barryli_site.deployer_secret_access_key
  sensitive   = true
}

output "site_barryli_cf_distribution_id" {
  description = "Barryli cloudfront distribution_id."
  value       = module.barryli_site.distribution_id
  sensitive   = true
}

output "site_barryli_bucket_name" {
  description = "Barryli site bucket name."
  value       = module.barryli_site.bucket_name
}

output "site_barryli_bucket_region" {
  description = "Barryli site bucket region."
  value       = module.barryli_site.bucket_region
}

output "s3_proxy_api_key" {
  description = "API key to access s3 proxy."
  value       = module.notes_pipeline.s3_proxy_api_key
  sensitive   = true
}

output "dynamo_proxy_api_key" {
  description = "API key to access dynamo proxy."
  value       = module.notes_pipeline.dynamo_proxy_api_key
  sensitive   = true
}

output "barryli_api_domain" {
  description = "API domain for barryli.ca"
  value       = aws_api_gateway_domain_name.barryli_api.domain_name
}

output "notes_pipeline_service_deployer_access_key_id" {
  description = "The AWS access key id that can deploy the notes pipeline."
  value       = module.notes_pipeline.service_deployer_access_key_id
}

output "notes_pipeline_service_deployer_secret_access_key" {
  description = "The Aws secret access key that can deploy the notes pipeline."
  value       = module.notes_pipeline.service_deployer_secret_access_key
  sensitive   = true
}
