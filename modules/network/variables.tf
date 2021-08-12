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