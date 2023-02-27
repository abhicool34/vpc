data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "${var.environment_name}-terraform-state-bucket"
    key    = "network.tfstate"
    region = "us-east-1"
  }
}