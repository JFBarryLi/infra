terraform {
  backend "s3" {
    bucket         = "barry-li-remote-state"
    key            = "barry-li/prod/terraform.tfstate"
    region         = "us-east-1"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
    dynamodb_table = "TerraformRemoteStateLock"
  }
}
