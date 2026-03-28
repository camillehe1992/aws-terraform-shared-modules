# Create NAT Gateway to allow private instances to access internet
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(local.tags, {
    Name = "nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = local.network.public_subnet_ids[0]

  tags = merge(local.tags, {
    Name = "nat-gateway"
  })
}

resource "aws_route" "private" {
  route_table_id         = local.network.private_route_table_id
  gateway_id             = aws_nat_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}
