# Infraestructura AWS para el Servicio de Órdenes

Este proyecto contiene la definición de infraestructura como código utilizando Terraform para aprovisionar los recursos AWS necesarios para el servicio de órdenes.

## Estructura del Proyecto

```
infra/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
├── modules/
│   └── orders_service/
│       ├── ecs.tf
│       ├── rds.tf
│       ├── alb.tf
│       ├── s3.tf
│       └── cloudwatch.tf
├── providers.tf
├── variables.tf
├── versions.tf
├── main.tf
└── outputs.tf
```

## Requisitos Previos

- Terraform >= 1.0 instalado
- AWS CLI configurado con credenciales válidas
- Acceso a la cuenta de AWS con permisos necesarios

## Configuración Inicial

### 1. Instalar Terraform

Descarga Terraform desde la página oficial: https://www.terraform.io/downloads

Opcionalmente, usa un gestor de versiones:

```bash
# con tfenv (Linux/macOS)
tfenv install 1.9.0
tfenv use 1.9.0

# con winget (Windows)
winget install HashiCorp.Terraform
```

### 2. Configurar AWS CLI

```bash
aws configure
# Ingresa:
# AWS Access Key ID: [tu access key]
# AWS Secret Access Key: [tu secret key]
# Default region name: us-east-1
# Default output format: json
```

### 3. Configurar Variables de Entorno

Establece las credenciales como variables de entorno:

```bash
# Linux/macOS
export AWS_ACCESS_KEY_ID="tu_access_key"
export AWS_SECRET_ACCESS_KEY="tu_secret_key"
export AWS_REGION="us-east-1"

# Windows (PowerShell)
$env:AWS_ACCESS_KEY_ID="tu_access_key"
$env:AWS_SECRET_ACCESS_KEY="tu_secret_key"
$env:AWS_REGION="us-east-1"
```

## Despliegue de Infraestructura

### Entorno de Desarrollo

```bash
cd infra/environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Entorno de Producción

```bash
cd infra/environments/prod
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Arquitectura de componentes

```
┌─────────────────────────────────────────────────────────────┐
│                      VPC (10.0.0.0/16)                       │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Private Subnets (AZ1, AZ2)             │   │
│  │  ┌──────────────────────────────────────────────┐  │   │
│  │  │              ECS Fargate Cluster              │  │   │
│  │  │  ┌─────────┐  ┌─────────┐  ┌─────────┐     │  │   │
│  │  │  │ Task 1  │  │ Task 2  │  │ Task N  │     │  │   │
│  │  │  └─────────┘  └─────────┘  └─────────┘     │  │   │
│  │  └──────────────────────────────────────────────┘  │   │
│  │                                                      │   │
│  │  ┌──────────────────────────────────────────────┐  │   │
│  │  │              RDS PostgreSQL                   │  │   │
│  │  │         (Multi-AZ Primary + Standby)          │  │   │
│  │  └──────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Public Subnets (ALB)                   │   │
│  │  ┌──────────────────────────────────────────────┐  │   │
│  │  │         Application Load Balancer             │  │   │
│  │  │    (SSL Termination, WAF, Health Checks)     │  │   │
│  │  └──────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    S3 Bucket                         │   │
│  │         (Logs,Artifacts,Backup Storage)             │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │               CloudWatch Logs                        │   │
│  │           (Application & Infrastructure)            │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## Recursos Aprovisionados

| Recurso | Descripción | Cantidad |
|---------|-------------|----------|
| VPC | Red virtual privada | 1 |
| Subnets | Subredes públicas y privadas | 4-6 |
| ECS Cluster | Cluster de contenedores | 1 |
| ECS Service | Servicio de órdenes | 1 |
| RDS Instance | Base de datos PostgreSQL | 2 (Primary + Standby) |
| ALB | Load Balancer de aplicación | 1 |
| S3 Bucket | Almacenamiento para logs y artefactos | 1 |
| CloudWatch | Logging y métricas | Varios |

## Gestión de Estado

El estado de Terraform se almacena localmente en este ejemplo. Para entornos de producción, se recomienda usar un backend remoto:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "orders-service/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
```

## Variables Configurables

Las principales variables configurables se encuentran en `variables.tf` y se personalizan por entorno en los archivos `terraform.tfvars` correspondientes.

## Limpieza de Recursos

Para destruir la infraestructura aprovisionada:

```bash
cd infra/environments/dev
terraform destroy -var-file="terraform.tfvars"
```

**Advertencia**: Esta operación elimina todos los recursos creados y puede ser irreversible.

## Referencias

- Documentación oficial de Terraform: https://www.terraform.io/docs
- Documentación AWS Provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- Best Practices de AWS: https://aws.amazon.com/architecture/
- ECS Fargate: https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-fargate.html
- RDS PostgreSQL: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html