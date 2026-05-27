resource "random_password" "db_password" {
  length           = var.db_password_length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "world" {
  name       = "${var.identifier}-subnets"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.identifier}-subnets"
    }
  )
}

resource "aws_db_instance" "world" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  db_name                 = var.db_name
  username                = var.username
  password                = random_password.db_password.result
  port                    = var.port
  storage_encrypted       = true
  publicly_accessible     = false
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.world.name
  vpc_security_group_ids  = var.vpc_security_group_ids

  tags = merge(
    var.tags,
    {
      Name = var.identifier
    }
  )
}

resource "aws_secretsmanager_secret" "world_db" {
  name = var.secret_name

  tags = merge(
    var.tags,
    {
      Name = var.secret_name
    }
  )
}

resource "aws_secretsmanager_secret_version" "world_db" {
  secret_id = aws_secretsmanager_secret.world_db.id
  secret_string = jsonencode({
    host     = aws_db_instance.world.address
    username = var.username
    password = random_password.db_password.result
    database = var.db_name
  })
}
