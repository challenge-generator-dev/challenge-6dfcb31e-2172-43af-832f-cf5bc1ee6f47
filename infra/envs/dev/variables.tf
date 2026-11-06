# Variables específicas para el entorno de desarrollo
# Estos valores sobrescriben las variables globales para adaptarse a las necesidades del entorno

variable "aws_region" {
  description = "Región de AWS para el entorno de desarrollo"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Identificador del entorno de desarrollo"
  type        = string
  default     = "dev"
}

variable "db_username" {
  description = "Nombre de usuario para la base de datos RDS en desarrollo"
  type        = string
  default     = "dev_admin"
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña para la base de datos RDS en desarrollo"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos RDS en desarrollo"
  type        = string
  default     = "db.t3.micro"
}

variable "ecs_desired_count" {
  description = "Número deseado de tareas de ECS en desarrollo"
  type        = number
  default     = 1
}

variable "ecs_max_capacity" {
  description = "Capacidad máxima de escalado para ECS en desarrollo"
  type        = number
  default     = 2
}

variable "alb_ingress_ports" {
  description = "Puertos de entrada para el ALB en desarrollo"
  type        = list(number)
  default     = [80]
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para desarrollo"
  type        = string
  default     = "orders-service-dev-bucket"
}

variable "cloudwatch_log_retention" {
  description = "Días de retención para logs en desarrollo"
  type        = number
  default     = 7
}

# Variables adicionales para desarrollo
variable "enable_debugging" {
  description = "Habilitar configuraciones de debugging para desarrollo"
  type        = bool
  default     = true
}

variable "mock_external_services" {
  description = "Usar servicios mock para integraciones externas en desarrollo"
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado en desarrollo"
  type        = bool
  default     = false
}