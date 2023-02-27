terraform {
  backend "s3" {
    bucket = "new-terraform-state-bucket"
    key    = "new/network.tfstate"
    region = "us-west-1"
  }
}