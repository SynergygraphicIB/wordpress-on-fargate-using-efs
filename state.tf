###########################################################################################
#                                                                                         #
#                           REMOTE STATE FILE                                             #
#                                                                                         #
###########################################################################################

// test upload 2

terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraform-synergydevops-state"
    key     = "wordpress-on-fargate/07oct-version"
    encrypt = true
    profile = "default"
  }
}
