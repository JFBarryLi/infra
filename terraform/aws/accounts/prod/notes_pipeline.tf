module "notes_pipeline" {
  source = "../../../modules/notes-pipeline"

  environment          = "prod"
  subnet_ids           = module.vpc.subnet_public_ids
  vpc_id               = module.vpc.vpc_id
  pipeline_bucket_name = "barry-li-travel-notes"
  log_bucket_name      = module.logging.bucket_name
  domain_name          = aws_api_gateway_domain_name.barryli_api.domain_name
  service_name         = "travel-data-pipeline"
  ecs_cluster_arn      = module.ecs.ecs_cluster_arn
}
