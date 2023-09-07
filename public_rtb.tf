
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id

  }

  tags = {
    Name = "Public_route_table_AZ"
  }
}

resource "aws_route_table_association" "public_rtb_assoc" {
  for_each = {
    AZ1 = "${aws_subnet.subnet[2].id}"
    AZ2 = "${aws_subnet.subnet[5].id}"
    AZ3 = "${aws_subnet.subnet[8].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rtb.id


}