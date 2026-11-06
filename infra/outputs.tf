# =============================================================================
# DEFINICION DE OUTPUTS - SERVICIO DE ORDENES
# =============================================================================
# Este archivo expone los valores resultantes de la infraestructura
# aprovisionada. Estos outputs son utilizados por otros modulos o
# para obtener informacion critica como endpoints y IDs de recursos.
# =============================================================================

# Outputs del modulo del servicio de ordenes
output "ecs_cluster_name" {
  description = "Nombre del cluster ECS donde se ejecuta el servicio"
  value       = module.orders_service.ecs_cluster_name
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = module.orders_service.ecs_service_name
}

output "ecs_task_definition_arn" {
  description = "ARN de la definicion de tarea ECS"
  value       = module.orders_service.ecs_task_definition_arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecucion de tareas ECS"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tareas ECS"
  value       = aws_iam_role.ecs_task_role.arn
}

# Outputs de la base de datos RDS
output "db_instance_id" {
  description = "Identificador de la instancia RDS"
  value       = module.orders_service.db_instance_id
}

output "db_instance_endpoint" {
  description = "Endpoint de la instancia de base de datos"
  value       = module.orders_service.db_instance_endpoint
}

output "db_instance_address" {
  description = "Direccion de la base de datos"
  value       = module.orders_service.db_instance_address
}

output "db_instance_port" {
  description = "Puerto de la base de datos"
  value       = module.orders_service.db_instance_port
}

output "db_name" {
  description = "Nombre de la base de datos"
  value       = module.orders_service.db_name
}

# Outputs del Application Load Balancer
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.orders_service.alb_arn
}

output "alb_name" {
  description = "Nombre del ALB"
  value       = module.orders_service.alb_name
}

output "alb_dns_name" {
  description = "Nombre DNS del ALB"
  value       = module.orders_service.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para DNS"
  value       = module.orders_service.alb_zone_id
}

output "alb_target_group_arn" {
  description = "ARN del target group del ALB"
  value       = module.orders_service.alb_target_group_arn
}

output "alb_listener_arn" {
  description = "ARN del listener del ALB"
  value       = module.orders_service.alb_listener_arn
}

# Outputs de S3
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = module.orders_service.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = module.orders_service.s3_bucket_arn
}

output "s3_bucket_region" {
  description = "Region del bucket S3"
  value       = module.orders_service.s3_bucket_region
}

# Outputs de CloudWatch
output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = module.orders_service.log_group_name
}

output "log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = module.orders_service.log_group_arn
}

output "cloudwatch_dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = module.orders_service.cloudwatch_dashboard_name
}

# Outputs de SNS
output "sns_topic_arn" {
  description = "ARN del topic SNS para eventos del servicio"
  value       = aws_sns_topic.orders_events.arn
}

output "sns_topic_name" {
  description = "Nombre del topic SNS para eventos del servicio"
  value       = aws_sns_topic.orders_events.name
}

# Outputs de SQS
output "sqs_queue_url" {
  description = "URL de la cola SQS"
  value       = aws_sqs_queue.orders_queue.url
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS"
  value       = aws_sqs_queue.orders_queue.arn
}

output "sqs_queue_name" {
  description = "Nombre de la cola SQS"
  value       = aws_sqs_queue.orders_queue.name
}

# Outputs de seguridad
output "security_group_id" {
  description = "ID del security group del servicio"
  value       = module.orders_service.security_group_id
}

output "iam_role_ecs_task_execution" {
  description = "Rol IAM para ejecucion de tareas ECS"
  value       = aws_iam_role.ecs_task_execution_role.name
}

output "iam_role_ecs_task" {
  description = "Rol IAM para tareas ECS"
  value       = aws_iam_role.ecs_task_role.name
}

# Outputs de red
output "vpc_id" {
  description = "ID de la VPC"
  value       = var.vpc_id
}

output "subnet_ids" {
  description = "IDs de las subnets"
  value       = var.subnet_ids
}

# Output combinado del endpoint del servicio
output "service_endpoint" {
  description = "Endpoint URL del servicio de ordenes"
  value       = "http://${module.orders_service.alb_dns_name}"
}

# Output para verificar si la infraestructura esta desplegada
output "deployment_status" {
  description = "Estado del despliegue de la infraestructura"
  value       = "Infraestructura aprovisionada exitosamente en el entorno: ${var.environment}"
}