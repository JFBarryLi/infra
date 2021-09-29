module "rd" {
  source = "../modules/remote-dev"

  ec2_on        = "0"
  ami           = "ami-089b5711e63812c2a"
  instance_type = "t2.micro"
}
