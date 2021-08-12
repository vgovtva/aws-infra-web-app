provider "aws" {
    region = var.deployment_region
    profile = "infra-deployer"
}

terraform {
  backend "s3" {}
}

module "network" {
  source = "./modules/network"
  deployment_region = var.deployment_region
  deployment_region_short = var.deployment_region_short
  output_bucket = var.output_bucket
  output_bucket_key_prefix = var.output_bucket_key_prefix
}
