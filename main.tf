provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-0cbc562f0dbc5383c " 
}

data "aws_security_group" "existing_sg" {
  id = "sg-0346ec3bc4f8e24d5" 
}


resource "aws_db_instance" "rds_mysql_product" {
  identifier = "product_db"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.35" 
  instance_class       = "db.t4g.micro"
  db_name              = "product_db"
  username             = "admin" 
  password             = "admin12345678"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name = "rds-challenge"
  tags = {
    Name = "rds instance product"
  }
}

resource "aws_db_instance" "rds_mysql_order" {
  identifier = "order_db"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.35" 
  instance_class       = "db.t4g.micro"
  db_name              = "order_db"
  username             = "admin" 
  password             = "admin12345678"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name = "rds-challenge"
  tags = {
    Name = "rds instance order"
  }
}

resource "aws_db_instance" "rds_mysql_payment" {
  identifier = "payment_db"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.35" 
  instance_class       = "db.t4g.micro"
  db_name              = "payment_db"
  username             = "admin" 
  password             = "admin12345678"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name = "rds-challenge"
  tags = {
    Name = "rds instance payment"
  }
}

resource "aws_db_instance" "rds_mysql_client" {
  identifier = "client_db"
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.35" 
  instance_class       = "db.t4g.micro"
  db_name              = "client_db"
  username             = "admin" 
  password             = "admin12345678"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name = "rds-challenge"
  tags = {
    Name = "rds instance client"
  }
}

output "db_instance_endpoint_product" {
  value = aws_db_instance.rds_mysql_product.endpoint
}

output "db_instance_endpoint_order" {
  value = aws_db_instance.rds_mysql_order.endpoint
}

output "db_instance_endpoint_payment" {
  value = aws_db_instance.rds_mysql_payment.endpoint
}

output "db_instance_endpoint_client" {
  value = aws_db_instance.rds_mysql_client.endpoint
}
