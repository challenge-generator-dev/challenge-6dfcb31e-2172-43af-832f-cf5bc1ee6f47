# Configuración de RDS para el servicio de órdenes
# Este módulo define la base de datos PostgreSQL con configuración de alta disponibilidad

# ========================================
# Subnet Group para RDS
# ========================================
resource "aws_db_subnet_group" "orders" {
  name       = "orders-db-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = var.common_tags
}

# ========================================
# RDS Instance Principal
# ========================================
resource "aws_db_instance" "orders_primary" {
  identifier     = "orders-db-primary"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  backup_retention_period = var.db_backup_retention
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  deletion_protection = var.environment == "prod" ? true : false
  skip_final_snapshot = var.environment == "prod" ? false : true
  final_snapshot_identifier = var.environment == "prod" ? "orders-db-final-snapshot" : null

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  performance_insights_enabled = var.environment == "prod"
  performance_insights_retention_period = var.environment == "prod" ? 7 : null

  tags = merge(var.common_tags, { Name = "orders-db-primary" })
}

# ========================================
# RDS Read Replica (solo en producción)
# ========================================
resource "aws_db_instance" "orders_replica" {
  count         = var.environment == "prod" ? 1 : 0
  identifier    = "orders-db-replica"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  source_db_instance_identifier = aws_db_instance.orders_primary.identifier
  replicate_source_db          = true

  skip_final_snapshot = true

  tags = merge(var.common_tags, { Name = "orders-db-replica" })
}

# ========================================
# Security Group para RDS
# ========================================
resource "aws_security_group" "rds" {
  name        = "orders-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

# ========================================
# Parameter Group para PostgreSQL
# ========================================
resource "aws_db_parameter_group" "orders" {
  name   = "orders-db-parameter-group"
  family = "postgres15"

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {
    name  = "shared_buffers"
    value = "131072"  # 512MB para db.t3.medium
  }

  parameter {
    name  = "effective_cache_size"
    value = "393216"  # 1.5GB
  }

  parameter {
    name  = "maintenance_work_mem"
    value = "65536"   # 256MB
  }

  parameter {
    name  = "checkpoint_completion_target"
    value = "0.9"
  }

  parameter {
    name  = "wal_buffers"
    value = "16"
  }

  parameter {
    name  = "default_statistics_target"
    value = "100"
  }

  parameter {
    name  = "random_page_cost"
    value = "1.1"
  }

  parameter {
    name  = "effective_io_concurrency"
    value = "200"
  }

  parameter {
    name  = "work_mem"
    value = "2621"  # 2.6MB
  }

  tags = var.common_tags
}

# ========================================
# Option Group para PostgreSQL
# ========================================
resource "aws_db_option_group" "orders" {
  name     = "orders-db-option-group"
  engine_name = "postgres"
  major_engine_version = "15"

  option {
    option_name = "LOG_CONNECTIONS"
  }

  option {
    option_name = "LOG_DISCONNECTIONS"
  }

  option {
    option_name = "LOG_LOCK_WAITS"
  }

  option {
    option_name = "LOG_temp_files"
    option_settings = [
      {
        name  = "log_temp_files"
        value = "0"
      }
    ]
  }

  tags = var.common_tags
}