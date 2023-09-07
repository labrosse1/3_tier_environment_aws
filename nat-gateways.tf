
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_nat_gateway" "nat_gw" {
  count         = 3
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.subnet[var.public_subnets_index[count.index]].id

  tags = {
    Name = "NAT gw AZ${count.index}"
  }
}

resource "aws_eip" "eip" {
  count      = 3
  depends_on = [aws_internet_gateway.internet_gw]
}