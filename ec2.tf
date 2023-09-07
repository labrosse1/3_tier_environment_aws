
resource "aws_instance" "ec2_instance" {
  count                  = 3
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.subnet[var.app_subnets_index[count.index]].id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh to ec2"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ssh from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["90.49.196.0/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}