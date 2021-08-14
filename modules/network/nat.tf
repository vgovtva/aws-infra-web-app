data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Set of subnets to create for nat gateways
  public_natgw_subnets = { for i in range(1,4): "subnet${i}" => {
      az = data.aws_availability_zones.available.names[i - 1]
      cidr = local.natgw_subnets[i - 1]
    }
  }
}

resource "aws_subnet" "natgw" {
  for_each = local.public_natgw_subnets
  vpc_id     = local.shared_output.vpc_id
  cidr_block = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "natgw-${each.key}"
  }
}

resource "aws_eip" "natgw" {
  for_each = local.public_natgw_subnets
  vpc = true
  tags = {
    Name = "natgw-ip"
  }
}

resource "aws_nat_gateway" "main" {
  depends_on = [aws_eip.natgw, aws_subnet.natgw]
  for_each = local.public_natgw_subnets

  connectivity_type = "public"
  allocation_id = aws_eip.natgw[each.key].id
  subnet_id = aws_subnet.natgw[each.key].id
  tags = {
    Name = "natgw-${each.key}"
  }
}

resource "aws_route_table" "natgw_egress" {
  vpc_id = local.infra_vpc_id
  tags = {
    Name = "natgw_egress_rt"
  }
}

resource "aws_route" "public_egress" {
  depends_on = [
    aws_route_table.natgw_egress,
    aws_internet_gateway.main
  ]
  route_table_id = aws_route_table.natgw_egress.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "natgw_egress" {
  depends_on = [
    aws_route_table.natgw_egress
  ]
  for_each = aws_nat_gateway.main
  subnet_id = aws_subnet.natgw[each.key].id
  route_table_id = aws_route_table.natgw_egress.id
}