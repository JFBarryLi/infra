module "vpc" {
  source = "../../../modules/vpc"

  vpc_cidr_block = "10.0.0.0/24"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]
}
