terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }
}

# Configuracion del provider AWS
# Se utiliza la version 5.65.0 del provider de AWS para garantizar compatibilidad
# con los recursos y features requeridos para el servicio de ordenes.
# El provider se configurara con las credenciales obtenidas del entorno
# o desde el archivo de configuracion de AWS CLI.
provider "aws" {
  region = var.aws_region

  # Configuracion de retry para manejar fallos transitorios de API
  retry_mode = "standard"
  max_retries = 5

  # Configuracion de endpoints personalizados (opcional)
  # endpoints {
  #   ec2        = "http://localhost:4566"
  #   s3         = "http://localhost:4566"
  #   dynamodb   = "http://localhost:4566"
  # }

  # Configuracion de acceso directo (sin asumir rol)
  # skip_credentials_validation = true
  # skip_requesting_account_id  = true
  # skip_metadata_api_check     = true

  # Perfil de AWS SSO para autenticacion
  # profile = "default"

  # Token de sesion para autenticacion temporal
  # token = "TOKEN"
}

# Configuracion de backend para almacenamiento de estado
# Por defecto se usa local, pero en produccion se recomienda S3
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Definicion de variables requeridas por el provider
# Estas variables deben ser proporcionadas al ejecutar terraform
variable "aws_region" {
  description = "Region de AWS donde se aprovisionara la infraestructura"
  type        = string
  default     = "us-east-1"
}