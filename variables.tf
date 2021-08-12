variable "deployment_region" {
  description = "deployment region"
  type        = string
  default     = "eu-central-1"
}

variable "deployment_region_short" {
  description = "deployment region"
  type        = string
  default     = "ec1"
}

variable "output_bucket" {
  description = "destination where to put object to share data across deployments"
  type        = string
  default     = "ec1-shop-terraform-state-bucket"
}

variable "output_bucket_key_prefix" {
  description = "destination where to put object to share data across deployments"
  type        = string
  default     = "terraform/infra/output"
}