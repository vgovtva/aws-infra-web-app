terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "infra-vpc"
  }
}

# TODO: Set up two way internet gateway (with public IP)
# TODO: Add subnet for NAT GW
# TODO: Add subnet for NAT GW with egress only

resource "aws_egress_only_internet_gateway" "example" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-egress-gw"
  }
}

# Needed for sharing vpc_id with other resources in the module
locals {
  vpc_id = aws_vpc.main.id
}

output "infra_vpc_id" {
  value = local.vpc_id
}
