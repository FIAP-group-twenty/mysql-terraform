provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-0cbc562f0dbc5383c " 
}

data "aws_security_group" "existing_sg" {
  id = "sg-0346ec3bc4f8e24d5" 
}


resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.35" 
  instance_class       = "db.t4g.micro"
  db_name              = "fiap"
  username             = "admin" 
  password             = "admin12345678"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name = "rds-challenge"
  tags = {
    Name = "rds instance"
  }
}

output "db_instance_endpoint" {
  value = aws_db_instance.rds_mysql.endpoint
}
