// Private subnets
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id
  count  = length(data.aws_availability_zones.available.names)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id

  }

  tags = {
    Name = "Private_route_table_AZ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_rtb_assoc_AZ1" {
  for_each = {
    AZ1  = "${aws_subnet.subnet[0].id}"
    AZ1a = "${aws_subnet.subnet[1].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb[0].id
}

resource "aws_route_table_association" "private_rtb_assoc_AZ2" {
  for_each = {
    AZ2  = "${aws_subnet.subnet[3].id}"
    AZ2a = "${aws_subnet.subnet[4].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb[1].id
}

resource "aws_route_table_association" "private_rtb_assoc_AZ3" {
  for_each = {
    AZ3  = "${aws_subnet.subnet[6].id}"
    AZ3a = "${aws_subnet.subnet[7].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb[2].id
}

