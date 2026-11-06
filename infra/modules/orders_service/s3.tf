# Bucket S3 para almacenar logs y archivos estáticos del servicio de órdenes
# SUPERFICIE DE PRÁCTICA: completar la configuración del bucket según requisitos del dominio

resource "aws_s3_bucket" "orders_service" {
  # El nombre del bucket debe ser único globalmente
  bucket = "${var.project_name}-orders-service-${var.environment}"

  tags = {
    Name        = "orders-service-bucket"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Configuración de versionado del bucket
resource "aws_s3_bucket_versioning" "orders_service" {
  bucket = aws_s3_bucket.orders_service.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configuración de lifecycle para transición a S3 Intelligent-Tiering
resource "aws_s3_bucket_lifecycle_configuration" "orders_service" {
  bucket = aws_s3_bucket.orders_service.id

  rule {
    id     = "archive-logs"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

# Bloqueo público del bucket (por seguridad)
resource "aws_s3_bucket_public_access_block" "orders_service" {
  bucket = aws_s3_bucket.orders_service.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket policy para permitir acceso desde CloudWatch Logs
resource "aws_s3_bucket_policy" "orders_service_logs" {
  bucket = aws_s3_bucket.orders_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudWatchLogsDelivery"
        Effect    = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.orders_service.arn}/logs/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}