locals {
  db_instance_name    = "rds-three-tier"
  db_engine           = "mysql"
  db_engine_version   = "8.0"
  publicly_accessible = false
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "main" {
  name       = local.db_instance_name
  subnet_ids = var.db_subnets
}

resource "aws_db_instance" "main" {
  identifier              = local.db_instance_name
  db_name                 = var.db_name
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_storage_size
  engine                  = local.db_engine
  engine_version          = local.db_engine_version
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [var.db_security_group]
  publicly_accessible     = local.publicly_accessible
  skip_final_snapshot     = local.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
}

resource "aws_db_instance" "main_replica" {
  identifier             = "${local.db_instance_name}-replica"
  replicate_source_db    = aws_db_instance.main.identifier
  instance_class         = var.db_instance_class
  apply_immediately      = true
  publicly_accessible    = local.publicly_accessible
  skip_final_snapshot    = local.skip_final_snapshot
  vpc_security_group_ids = [var.db_security_group]
}
