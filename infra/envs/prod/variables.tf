# Variables específicas para el entorno de producción
# Estos valores deben ser configurados cuidadosamente para garantizar rendimiento y seguridad

variable "aws_region" {
  description = "Región de AWS para el entorno de producción"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Identificador del entorno de producción"
  type        = string
  default     = "prod"
}

variable "db_username" {
  description = "Nombre de usuario para la base de datos RDS en producción"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña para la base de datos RDS en producción"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos RDS en producción"
  type        = string
  default     = "db.t3.large"
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado para RDS en producción (GB)"
  type        = number
  default     = 100
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos para producción"
  type        = string
  default     = "15.4"
}

variable "ecs_task_cpu" {
  description = "CPU asignada a tareas ECS en producción"
  type        = number
  default     = 1024
}

variable "ecs_task_memory" {
  description = "Memoria asignada a tareas ECS en producción (MB)"
  type        = number
  default     = 2048
}

variable "ecs_desired_count" {
  description = "Número deseado de tareas ECS en producción"
  type        = number
  default     = 4
}

variable "ecs_max_capacity" {
  description = "Capacidad máxima de escalado para ECS en producción"
  type        = number
  default     = 10
}

variable "alb_ingress_ports" {
  description = "Puertos de entrada para el ALB en producción"
  type        = list(number)
  default     = [80, 443]
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para producción"
  type        = string
  default     = "orders-service-prod-bucket"
}

variable "cloudwatch_log_retention" {
  description = "Días de retención para logs en producción"
  type        = number
  default     = 90
}

# Variables de seguridad para producción
variable "enable_encryption" {
  description = "Habilitar encriptación para todos los recursos en producción"
  type        = bool
  default     = true
}

variable "enable_backups" {
  description = "Habilitar backups automáticos para RDS en producción"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Período de retención para backups de RDS (días)"
  type        = number
  default     = 35
}

variable "enable_multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS en producción"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación para recursos críticos"
  type        = bool
  default     = true
}

# Variables de monitoreo para producción
variable "enable_detailed_monitoring" {
  description = "Habilitar monitoreo detallado para ECS y RDS en producción"
  type        = bool
  default     = true
}

variable "enable_alarms" {
  description = "Habilitar alarmas de CloudWatch para monitoreo proactivo"
  type        = bool
  default     = true
}

# Variables de escalado para producción
variable "enable_autoscaling" {
  description = "Habilitar autoescalado para ECS en producción"
  type        = bool
  default     = true
}

variable "autoscaling_cpu_target" {
  description = "Porcentaje objetivo de utilización de CPU para autoescalado"
  type        = number
  default     = 70
}

variable "autoscaling_memory_target" {
  description = "Porcentaje objetivo de utilización de memoria para autoescalado"
  type        = number
  default     = 70
}