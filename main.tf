provider "aws" {
    region = "eu-central-1"
}

terraform {
  backend "s3" {}
}

module "network" {
  source = "./modules/network"
  deployment_region = var.deployment_region
  deployment_region_short = var.deployment_region_short
}
