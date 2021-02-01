module "remote-state" {
  source = "../../../modules/remote-state//"

  state_bucket_name = "barry-li-remote-state"
  log_bucket_name   = module.logging.bucket_name
  create_lock_table = true
}
