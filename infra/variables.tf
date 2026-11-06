# Definición de variables globales para la configuración de Terraform
# Estas variables se utilizan en todos los módulos y recursos del proyecto

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, staging)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
  default     = "orders-service"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC del servicio de órdenes"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de CIDRs para subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subredes privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "db_username" {
  description = "Nombre de usuario para la base de datos RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña para la base de datos RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado para la base de datos RDS (GB)"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "15.4"
}

variable "ecs_task_cpu" {
  description = "CPU asignada a cada tarea de ECS (en unidades de CPU)"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "Memoria asignada a cada tarea de ECS (en MB)"
  type        = number
  default     = 512
}

variable "ecs_desired_count" {
  description = "Número deseado de tareas de ECS en ejecución"
  type        = number
  default     = 2
}

variable "ecs_max_capacity" {
  description = "Capacidad máxima de escalado para el servicio ECS"
  type        = number
  default     = 4
}

variable "alb_ingress_ports" {
  description = "Puertos de entrada para el Application Load Balancer"
  type        = list(number)
  default     = [80, 443]
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenar archivos estáticos"
  type        = string
}

variable "cloudwatch_log_retention" {
  description = "Días de retención para los logs en CloudWatch"
  type        = number
  default     = 30
}

# Validación de variables para asegurar valores consistentes
locals {
  valid_environments = ["dev", "prod", "staging"]
  
  # Validación del entorno
  environment_validation = contains(local.valid_environments, var.environment) ? null : file("ERROR: El entorno '${var.environment}' no es válido. Valores permitidos: ${jsonencode(local.valid_environments)}")
  
  # Validación de la región de AWS
  aws_regions = [
    "us-east-1", "us-east-2", "us-west-1", "us-west-2",
    "eu-west-1", "eu-central-1", "ap-southeast-1", "ap-northeast-1"
  ]
  region_validation = contains(local.aws_regions, var.aws_region) ? null : file("ERROR: La región '${var.aws_region}' no es válida. Valores permitidos: ${jsonencode(local.aws_regions)}")
  
  # Validación de CIDR de VPC
  vpc_cidr_validation = can(cidrhost(var.vpc_cidr, 0)) ? null : file("ERROR: El CIDR '${var.vpc_cidr}' no es válido")
  
  # Validación de subredes
  subnets_validation = alltrue([
    for subnet in concat(var.public_subnets, var.private_subnets) : can(cidrhost(subnet, 0))
  ]) ? null : file("ERROR: Alguna de las subredes no tiene un CIDR válido")
}