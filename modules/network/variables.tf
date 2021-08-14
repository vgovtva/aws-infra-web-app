# Module wide variables
variable "deployment_region" {
  description = "deployment region"
  type        = string
}

variable "deployment_region_short" {
  description = "deployment region"
  type        = string
}

variable "output_bucket" {
  description = "destination where to put object to share data across deployments"
  type        = string
}

variable "output_bucket_key_prefix" {
  description = "destination where to put object to share data across deployments"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Cidr block to reserve for the subnet"
  default = "10.0.0.0/16"
}

locals {
  # Set of public subnets with natgw
  # First 26 block in vpc, then three 28s inside of it.
  natgw_subnets = cidrsubnets(cidrsubnet(var.vpc_cidr_block, 10, 0), 2, 2, 2)
}
