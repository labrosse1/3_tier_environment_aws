
resource "aws_vpc" "vpc" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true

}

resource "aws_subnet" "subnet" {
  count             = var.subnets_nb
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[var.availability_zone_index[count.index]]

  tags = {
    Name = "Subnet_${count.index + 1}"
  }

}




