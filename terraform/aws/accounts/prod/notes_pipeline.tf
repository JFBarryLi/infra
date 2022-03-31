module "notes_pipeline" {
  source = "../../../modules/notes-pipeline"

  environment          = "prod"
  pipeline_bucket_name = "barry-li-travel-notes"
  log_bucket_name      = module.logging.bucket_name
}
