module "rd" {
  source = "../modules/remote-dev"

  ec2_on        = "1"
  instance_type = "t2.micro"
  key_name      = "remote_dev"
}
