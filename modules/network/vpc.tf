terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "infra-vpc"
  }
}

resource "aws_egress_only_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-egress-gw"
  }
}

# Needed for sharing vpc_id with other resources in the module
locals {
  shared_output = {
    vpc_id = aws_vpc.main.id
  }
}

locals {
  infra_vpc_id = local.shared_output.vpc_id
}


