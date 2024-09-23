provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL inbound traffic"
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
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
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    Name = "rds instance"
  }
}

output "db_instance_endpoint" {
  value = aws_db_instance.rds_mysql.endpoint
}
