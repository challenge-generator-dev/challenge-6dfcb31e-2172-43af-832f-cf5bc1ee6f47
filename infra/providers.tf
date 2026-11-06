# Configuración de los providers necesarios para el aprovisionamiento de infraestructura en AWS
# Este archivo define los providers y sus versiones para garantizar consistencia en el despliegue.

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

# Configuración del provider de AWS para la región us-east-1
# Las credenciales se gestionan mediante variables de entorno para mayor seguridad
provider "aws" {
  region = var.aws_region
  
  # Configuración opcional para asumir roles en entornos multi-cuenta
  # Esto permite delegar permisos específicos sin exponer credenciales principales
  assume_role {
    role_arn = var.aws_assume_role_arn
  }
  
  # Configuración de endpoints personalizados para servicios específicos
  # Útil en entornos de desarrollo o testing para apuntar a servicios locales
  endpoints {
    ec2 = var.aws_ec2_endpoint
    rds = var.aws_rds_endpoint
    s3  = var.aws_s3_endpoint
  }
  
  # Configuración de tags por defecto para todos los recursos creados
  # Facilita la identificación y gestión de costos en AWS
  default_tags {
    tags = {
      Environment = var.environment
      Service     = "orders-service"
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración del provider de AWS para la región us-west-2 (para replicación multi-región)
# Se utiliza para servicios que requieren alta disponibilidad geográfica
provider "aws" {
  alias  = "west"
  region = "us-west-2"
  
  default_tags {
    tags = {
      Environment = var.environment
      Service     = "orders-service"
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración del backend remoto para almacenar el estado de Terraform
# Se utiliza S3 con bloqueo de estado mediante DynamoDB para evitar conflictos
terraform {
  backend "s3" {
    bucket         = "tf-state-orders-service"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock-orders-service"
  }
}

# Variables necesarias para la configuración del provider AWS
# Estas variables se definen en el archivo variables.tf y se sobrescriben por entorno
variable "aws_region" {
  description = "Región de AWS donde se aprovisionarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "aws_assume_role_arn" {
  description = "ARN del rol de AWS que se asumirá para el despliegue"
  type        = string
  default     = null
}

variable "aws_ec2_endpoint" {
  description = "Endpoint personalizado para el servicio EC2 (opcional)"
  type        = string
  default     = null
}

variable "aws_rds_endpoint" {
  description = "Endpoint personalizado para el servicio RDS (opcional)"
  type        = string
  default     = null
}

variable "aws_s3_endpoint" {
  description = "Endpoint personalizado para el servicio S3 (opcional)"
  type        = string
  default     = null
}

variable "environment" {
  description = "Entorno en el que se aprovisionarán los recursos (dev, prod, etc.)"
  type        = string
}