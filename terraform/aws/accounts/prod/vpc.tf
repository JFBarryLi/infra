module "vpc" {
  source = "../../../modules/vpc"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]
}
