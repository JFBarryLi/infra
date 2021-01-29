provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "cert"
  region = "us-east-1"
}

provider "aws" {
  alias  = "dns"
  region = "us-east-1"
}
