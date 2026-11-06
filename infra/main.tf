# =============================================================================
# CONFIGURACION PRINCIPAL DE TERRAFORM - SERVICIO DE ORDENES
# =============================================================================
# Este archivo define la estructura principal de la infraestructura AWS
# para el servicio de ordenes. Utiliza una arquitectura modular que
# permite la reutilizacion y separacion de responsabilidades.
#
# Componentes principales:
# - ECS Fargate para computo del servicio
# - RDS PostgreSQL para persistencia de datos
# - Application Load Balancer para balanceo de carga
# - S3 para almacenamiento de archivos estaticos
# - CloudWatch para monitoreo y logging
# =============================================================================

# Modulo del servicio de ordenes
# Este modulo encapsula todos los recursos necesarios para el servicio
# y permite su despliegue en diferentes entornos (dev, prod)
module "orders_service" {
  source = "../modules/orders_service"

  # Parametros comunes del servicio
  environment           = var.environment
  service_name          = var.service_name
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  security_group_ids    = var.security_group_ids

  # Configuracion de ECS
  ecs_cluster_name      = var.ecs_cluster_name
  container_image       = var.container_image
  container_port        = var.container_port
  desired_count         = var.desired_count
  min_count             = var.min_count
  max_count             = var.max_count

  # Configuracion de base de datos
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  db_engine_version     = var.db_engine_version
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password

  # Configuracion de ALB
  alb_name              = var.alb_name
  alb_port              = var.alb_port
  alb_protocol          = var.alb_protocol
  certificate_arn       = var.certificate_arn

  # Configuracion de S3
  s3_bucket_name        = var.s3_bucket_name
  s3_versioning_enabled = var.s3_versioning_enabled

  # Configuracion de CloudWatch
  log_group_name        = var.log_group_name
  log_retention_days    = var.log_retention_days
  alarm_email           = var.alarm_email

  # Tags comunes
  tags = var.common_tags
}

# =============================================================================
# CONFIGURACION ADICIONAL DE RECURSOS COMPARTIDOS
# =============================================================================

# Recurso de SNS para notificaciones de eventos del servicio
resource "aws_sns_topic" "orders_events" {
  name         = "${var.service_name}-events"
  display_name = "Ordenes - Eventos del Servicio"

  tags = var.common_tags
}

# Recurso de SQS para cola de mensajes asincronos
resource "aws_sqs_queue" "orders_queue" {
  name                       = "${var.service_name}-queue"
  visibility_timeout_seconds = 300
  message_retention_seconds  = 86400
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0

  tags = var.common_tags
}

# Politica de acceso a la cola SQS
resource "aws_sqs_queue_policy" "orders_queue_policy" {
  queue_url = aws_sqs_queue.orders_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "orders-queue-policy"
    Statement = [
      {
        Sid       = "AllowS3Events"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.orders_queue.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = "arn:aws:s3:::${var.s3_bucket_name}"
          }
        }
      }
    ]
  })
}

# Recurso de IAM role para ejecucion de tareas ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.service_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

# Politica gestionada de ECS para task execution
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Recurso de IAM role para tareas del servicio
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.service_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

# Politica inline para acceso a S3
resource "aws_iam_policy" "s3_access_policy" {
  name = "${var.service_name}-s3-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3ReadAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      },
      {
        Sid    = "AllowS3WriteAccess"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_s3_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}