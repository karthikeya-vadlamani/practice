# DB SUBNET GROUP

resource "aws_db_subnet_group" "main" {
  name       = "dev-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "dev-db-subnet-group"
  }
}

# SECURITY GROUP

resource "aws_security_group" "rds_sg" {
  name        = "dev-rds-sg"
  description = "Allow MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL"

    from_port = 3306
    to_port   = 3306

    protocol = "tcp"

    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-rds-sg"
  }
}

# RDS INSTANCE

resource "aws_db_instance" "main" {
  identifier = "dev-mysql-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false

  multi_az = false

  storage_encrypted = true

  deletion_protection = false

  skip_final_snapshot = true

  backup_retention_period = 0

  tags = {
    Name = "dev-mysql-db"
  }
}

# IAM ROLE

resource "aws_iam_role" "rds_access_role" {
  name = "rds-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM POLICY

resource "aws_iam_policy" "rds_connect_policy" {
  name = "rds-connect-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "rds-db:connect"
        ]

        Resource = "*"
      }
    ]
  })
}

# ATTACH POLICY

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.rds_access_role.name
  policy_arn = aws_iam_policy.rds_connect_policy.arn
}