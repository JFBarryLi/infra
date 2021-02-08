terraform {
  backend "s3" {
    bucket         = "barry-li-remote-state"
    key            = "barry-li/github/terraform.tfstate"
    region         = "us-east-1"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
    dynamodb_table = "TerraformRemoteStateLock"
  }
}

data "terraform_remote_state" "prod" {
  backend = "s3"

  config = {
    bucket = "barry-li-remote-state"
    key    = "env:/prod/terraform.tfstate"
    region = "us-east-1"
  }
}
