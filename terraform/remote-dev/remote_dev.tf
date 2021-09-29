module "rd" {
  source = "../modules/remote-dev"

  ec2_on        = var.ec2_on
  instance_type = var.instance_type
  key_name      = "remote_dev"
}
