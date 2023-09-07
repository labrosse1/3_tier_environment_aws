resource "aws_security_group" "database_sg" {
  name        = "enable mysql access"
  description = "Allow mysql access"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "mysql access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_ssh.id]//repalce with the app server security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database security group"
  }
}

resource "aws_db_subnet_group" "database_subnet_group"{

    name = "database-subnets"
    subnet_ids = [aws_subnet.subnet[0].id, aws_subnet.subnet[3].id, aws_subnet.subnet[6].id ]
}

resource "aws_db_instance" "db_instance"{
    engine = "mysql"
    engine_version = "8.0.31"
    multi_az = false 
    identifier = "dev-rds-instance"
    username = "haroon"
    password = "defaultPw"
    instance_class = "db.t2.micro"
    allocated_storage = 200
    db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
    vpc_security_group_ids = [aws_security_group.database_sg.id]
    db_name = "applicationdb"
    skip_final_snapshot = true 
}