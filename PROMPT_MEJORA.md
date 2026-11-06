# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/ecs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/rds.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/alb.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/s3.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/cloudwatch.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/envs/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/envs/dev/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/envs/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/envs/prod/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /orders`
  - `GET /orders/{id}`
  - `PUT /orders/{id}`
  - `DELETE /orders/{id}`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setId`: Se invoca `setId` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setCreatedAt`: Se invoca `setCreatedAt` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setUpdatedAt`: Se invoca `setUpdatedAt` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getItems`: Se invoca `getItems` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getCustomerId`: Se invoca `getCustomerId` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getStatus`: Se invoca `getStatus` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getProductId`: Se invoca `getProductId` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getProductName`: Se invoca `getProductName` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getPrice`: Se invoca `getPrice` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getQuantity`: Se invoca `getQuantity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `OrderService.getOrderById`: Se invoca `getOrderById` sobre `OrderService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `Order.isPresent`: Se invoca `isPresent` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `Order.get`: Se invoca `get` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform (corrida e2e 20261106172943501), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionamiento de Infraestructura con Terraform para el Servicio de Órdenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración Inicial de Terraform — objetivo: Configurar el entorno de Terraform para aprovisionar la infraestructura AWS. — entregable (NO resolver): Entorno de Terraform configurado y autenticado en AWS.
- Fase 2: Definición de Recursos de Infraestructura — objetivo: Definir los recursos de infraestructura necesarios para el servicio de órdenes en Terraform. — entregable (NO resolver): Archivo de configuración de Terraform con los recursos de infraestructura definidos.
- Fase 3: Aprovisionamiento y Verificación de Infraestructura — objetivo: Aprovisionar la infraestructura definida en Terraform y verificar su correcto funcionamiento. — entregable (NO resolver): Infraestructura aprovisionada y verificada en AWS.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# AWS Credentials (should be provided via environment variables or AWS CLI)
aws_region = "us-east-1"

# Network Configuration
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# ECS Configuration
ecs_cluster_name = "orders-service-dev"
ec2_instance_type = "t3.medium"
min_capacity = 1
max_capacity = 2

# RDS Configuration
rds_instance_class = "db.t3.micro"
rds_engine_version = "15.5"
rds_allocated_storage = 20
rds_username = "orders_admin"
rds_password = "secure_password_123!"
rds_database_name = "orders_dev"

# ALB Configuration
alb_name = "orders-service-alb-dev"

# S3 Configuration
s3_bucket_name = "orders-service-uploads-dev"

# CloudWatch Logs
cloudwatch_log_group_name = "/ecs/orders-service-dev"

# Tags
environment = "dev"
project     = "orders-service"

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/envs/dev/variables.tf ===
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

// === ARCHIVO: infra/envs/prod/variables.tf ===
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

// === ARCHIVO: infra/versions.tf ===
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

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/modules/orders_service/ecs.tf ===
# Configuración del servicio ECS para el servicio de órdenes
# Este módulo define el cluster ECS y la task definition necesaria para ejecutar el servicio

# ========================================
# ECS Cluster
# ========================================
resource "aws_ecs_cluster" "orders" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = var.common_tags
}

# ========================================
# Task Definition
# ========================================
resource "aws_ecs_task_definition" "orders" {
  family                   = "orders-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "orders-service"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "ENV", value = var.environment },
        { name = "LOG_LEVEL", value = var.log_level }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/orders-service"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = var.common_tags
}

# ========================================
# ECS Service
# ========================================
resource "aws_ecs_service" "orders" {
  name            = "orders-service"
  cluster         = aws_ecs_cluster.orders.id
  task_definition = aws_ecs_task_definition.orders.arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "orders-service"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_target_group.orders]

  deployment_controller {
    type = "ECS"
  }

  tags = var.common_tags
}

# ========================================
# IAM Roles para ECS
# ========================================
resource "aws_iam_role" "ecs_execution_role" {
  name = "orders-ecs-execution-role"

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
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "orders-ecs-task-role"

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
}

# ========================================
# Security Group para las tareas ECS
# ========================================
resource "aws_security_group" "ecs_tasks" {
  name        = "orders-ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

// === ARCHIVO: infra/modules/orders_service/rds.tf ===
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

// === ARCHIVO: infra/modules/orders_service/alb.tf ===
# Configuración del Application Load Balancer para el servicio de órdenes
# Este módulo define el ALB que distribuye el tráfico al servicio ECS

# ========================================
# ALB Security Group
# ========================================
resource "aws_security_group" "alb" {
  name        = "orders-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
# Application Load Balancer
# ========================================
resource "aws_lb" "orders" {
  name               = "orders-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.environment == "prod"

  access_logs {
    bucket  = var.alb_log_s3_bucket
    prefix  = "orders-alb"
    enabled = true
  }

  tags = var.common_tags
}

# ========================================
# Target Group para el servicio ECS
# ========================================
resource "aws_lb_target_group" "orders" {
  name     = "orders-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = var.health_check_path
    matcher             = "200"
  }

  stickiness {
    enabled = true
    type    = "lb_cookie"
    cookie_duration = 86400
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}

# ========================================
# Listener HTTP (redirige a HTTPS)
# ========================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.orders.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# ========================================
# Listener HTTPS
# ========================================
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.orders.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }
}

# ========================================
# Listener Rule para métricas
# ========================================
resource "aws_lb_listener_rule" "metrics" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }

  condition {
    path_pattern {
      values = ["/metrics*", "/health*", "/ready*"]
    }
  }
}

# ========================================
# Listener Rule para API orders
# ========================================
resource "aws_lb_listener_rule" "api_orders" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }

  condition {
    path_pattern {
      values = ["/api/orders/*", "/api/orders"]
    }
  }
}

// === ARCHIVO: infra/modules/orders_service/s3.tf ===
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

// === ARCHIVO: infra/modules/orders_service/cloudwatch.tf ===
# Alarmas y métricas de CloudWatch para monitorear el servicio de órdenes
# SUPERFICIE DE PRÁCTICA: configurar umbrales y acciones de las alarmas

# Grupo de logs para el servicio
resource "aws_cloudwatch_log_group" "orders_service" {
  name              = "/aws/orders-service/${var.environment}"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "orders-service-logs"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Métrica personalizada: órdenes procesadas por minuto
resource "aws_cloudwatch_metric_alarm" "orders_processed_rate" {
  alarm_name          = "${var.project_name}-orders-processed-rate-${var.environment}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "OrdersProcessed"
  namespace           = "OrdersService"
  period              = "60"
  statistic           = "Sum"
  threshold           = var.min_orders_per_minute
  alarm_description   = "Alerta cuando el número de órdenes procesadas está por debajo del umbral mínimo"
  treat_missing_data  = "breaching"

  tags = {
    Name        = "orders-processed-rate-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de latencia promedio de procesamiento
resource "aws_cloudwatch_metric_alarm" "processing_latency" {
  alarm_name          = "${var.project_name}-processing-latency-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "ProcessingLatency"
  namespace           = "OrdersService"
  period              = "300"
  statistic           = "Average"
  threshold           = var.max_processing_latency_ms
  alarm_description   = "Alerta cuando la latencia de procesamiento supera el umbral máximo"
  treat_missing_data  = "missing"

  tags = {
    Name        = "processing-latency-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de tasa de errores
resource "aws_cloudwatch_metric_alarm" "error_rate" {
  alarm_name          = "${var.project_name}-error-rate-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ErrorRate"
  namespace           = "OrdersService"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_error_rate_percent
  alarm_description   = "Alerta cuando la tasa de errores supera el umbral permitido"
  treat_missing_data  = "breaching"

  tags = {
    Name        = "error-rate-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de uso de CPU del ECS
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization" {
  alarm_name          = "${var.project_name}-ecs-cpu-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_cpu_utilization_percent
  alarm_description   = "Alerta cuando el uso de CPU del cluster ECS supera el 80%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "ecs-cpu-utilization-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Alarma de uso de memoria del ECS
resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization" {
  alarm_name          = "${var.project_name}-ecs-memory-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.max_memory_utilization_percent
  alarm_description   = "Alerta cuando el uso de memoria del cluster ECS supera el 80%"
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "ecs-memory-utilization-alarm"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Dashboard de CloudWatch para el servicio
resource "aws_cloudwatch_dashboard" "orders_service" {
  dashboard_name = "${var.project_name}-orders-service-${var.environment}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["OrdersService", "OrdersProcessed", {"stat" = "Sum"}],
            [".", ".", {"stat" = "Sum"}]
          ]
          period  = 60
          stat    = "Sum"
          region  = var.aws_region
          title   = "Órdenes Procesadas"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["OrdersService", "ProcessingLatency", {"stat" = "Average"}],
            [".", ".", {"stat" = "Maximum"}]
          ]
          period  = 300
          stat    = "Average"
          region  = var.aws_region
          title   = "Latencia de Procesamiento"
        }
      }
    ]
  })
}

// === ARCHIVO: infra/envs/dev/main.tf ===
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }

  backend "s3" {
    bucket = "terraform-state-${var.project_name}-dev"
    key    = "envs/dev/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "development"
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

module "orders_service" {
  source = "../../modules/orders_service"

  environment           = "dev"
  project_name          = var.project_name
  aws_region            = var.aws_region
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  db_instance_class     = "db.t3.micro"
  ecs_cluster_name      = "${var.project_name}-orders-dev"
  ecs_desired_count     = 1
  ecs_cpu              = 256
  ecs_memory           = 512
  alb_name             = "${var.project_name}-orders-dev"
  s3_bucket_name       = "${var.project_name}-orders-dev"
  log_retention_days   = 7
}

// === ARCHIVO: infra/envs/prod/main.tf ===
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }

  backend "s3" {
    bucket = "terraform-state-${var.project_name}-prod"
    key    = "envs/prod/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "production"
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

module "orders_service" {
  source = "../../modules/orders_service"

  environment           = "prod"
  project_name          = var.project_name
  aws_region            = var.aws_region
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  db_instance_class     = "db.t3.medium"
  ecs_cluster_name      = "${var.project_name}-orders-prod"
  ecs_desired_count     = 3
  ecs_cpu              = 1024
  ecs_memory           = 2048
  alb_name             = "${var.project_name}-orders-prod"
  s3_bucket_name       = "${var.project_name}-orders-prod"
  log_retention_days   = 30
}

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.5.6</version>
        <relativePath/>
    </parent>
    
    <groupId>com.pragma</groupId>
    <artifactId>orders</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>orders</name>
    <description>Servicio de órdenes con infraestructura AWS</description>
    
    <properties>
        <java.version>21</java.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-sqs</artifactId>
            <version>1.12.760</version>
        </dependency>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-dynamodb</artifactId>
            <version>1.12.760</version>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/java/com/pragma/orders/Application.java ===
package com.pragma.orders;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = "com.pragma.orders.infrastructure.entity")
@EnableJpaRepositories(basePackages = "com.pragma.orders.infrastructure.repository")
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: orders
  
  datasource:
    url: jdbc:postgresql://${DB_HOST:localhost}:${DB_PORT:5432}/${DB_NAME:orders}
    username: ${DB_USER:postgres}
    password: ${DB_PASSWORD:postgres}
    driver-class-name: org.postgresql.Driver
  
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.PostgreSQLDialect

server:
  port: 8080
  servlet:
    context-path: /

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics

aws:
  region: ${AWS_REGION:us-east-1}
  sqs:
    order-queue-url: ${AWS_SQS_ORDER_QUEUE_URL}
  dynamodb:
    order-table-name: ${AWS_DYNAMODB_ORDER_TABLE_NAME:Orders}
    endpoint: ${AWS_DYNAMODB_ENDPOINT:http://localhost:4566}

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/model/Order.java ===
package com.pragma.orders.domain.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class Order {
    private UUID id;
    private UUID customerId;
    private List<OrderItem> items;
    private OrderStatus status;
    private BigDecimal totalAmount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Order(UUID customerId, List<OrderItem> items) {
        this.id = UUID.randomUUID();
        this.customerId = customerId;
        this.items = items;
        this.status = OrderStatus.PENDING;
        this.totalAmount = calculateTotalAmount();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public UUID getCustomerId() {
        return customerId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }

    private BigDecimal calculateTotalAmount() {
        return items.stream()
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static class OrderItem {
        private UUID productId;
        private String productName;
        private BigDecimal price;
        private int quantity;

        public OrderItem(UUID productId, String productName, BigDecimal price, int quantity) {
            this.productId = productId;
            this.productName = productName;
            this.price = price;
            this.quantity = quantity;
        }

        public UUID getProductId() {
            return productId;
        }

        public String getProductName() {
            return productName;
        }

        public BigDecimal getPrice() {
            return price;
        }

        public int getQuantity() {
            return quantity;
        }
    }

    public enum OrderStatus {
        PENDING,
        PROCESSING,
        COMPLETED,
        CANCELLED
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/port/OrderRepository.java ===
package com.pragma.orders.domain.port;

import com.pragma.orders.domain.model.Order;
import java.util.Optional;
import java.util.UUID;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(UUID id);
    void deleteById(UUID id);
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java ===
package com.pragma.orders.infrastructure.adapter;




import com.pragma.orders.domain.model.OrderStatus;
import com.pragma.orders.domain.model.OrderItem;
import com.pragma.orders.infrastructure.repository.SpringDataOrderRepository;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import com.pragma.orders.infrastructure.entity.OrderEntity;
import com.pragma.orders.infrastructure.entity.OrderItemEntity;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class OrderJpaRepository implements OrderRepository {

    private final SpringDataOrderRepository springDataOrderRepository;

    public OrderJpaRepository(SpringDataOrderRepository springDataOrderRepository) {
        this.springDataOrderRepository = springDataOrderRepository;
    }

    @Override
    public Order save(Order order) {
        OrderEntity entity = toEntity(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return toDomain(savedEntity);
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id).map(this::toDomain);
    }

    @Override
    public void deleteById(UUID id) {
        springDataOrderRepository.deleteById(id);
    }

    private OrderEntity toEntity(Order order) {
        OrderEntity entity = new OrderEntity();
        entity.setId(order.getId());
        entity.setCustomerId(order.getCustomerId());
        entity.setStatus(order.getStatus().name());
        entity.setTotalAmount(order.getTotalAmount());
        entity.setCreatedAt(order.getCreatedAt());
        entity.setUpdatedAt(order.getUpdatedAt());

        List<OrderItemEntity> itemEntities = order.getItems().stream()
                .map(item -> {
                    OrderItemEntity itemEntity = new OrderItemEntity();
                    itemEntity.setOrder(entity);
                    itemEntity.setProductId(item.getProductId());
                    itemEntity.setProductName(item.getProductName());
                    itemEntity.setPrice(item.getPrice());
                    itemEntity.setQuantity(item.getQuantity());
                    return itemEntity;
                })
                .collect(Collectors.toList());

        entity.setItems(itemEntities);
        return entity;
    }

    private Order toDomain(OrderEntity entity) {
        List<Order.OrderItem> items = entity.getItems().stream()
                .map(item -> new Order.OrderItem(
                        item.getProductId(),
                        item.getProductName(),
                        item.getPrice(),
                        item.getQuantity()
                ))
                .collect(Collectors.toList());

        Order order = new Order(entity.getCustomerId(), items);
        order.setStatus(Order.OrderStatus.valueOf(entity.getStatus()));
        return order;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/entity/OrderEntity.java ===
package com.pragma.orders.infrastructure.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
public class OrderEntity {
    @Id
    private UUID id;

    @Column(nullable = false)
    private UUID customerId;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItemEntity> items;

    @Column(nullable = false)
    private String status;

    @Column(nullable = false)
    private BigDecimal totalAmount;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private LocalDateTime updatedAt;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UUID getCustomerId() {
        return customerId;
    }

    public void setCustomerId(UUID customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemEntity> getItems() {
        return items;
    }

    public void setItems(List<OrderItemEntity> items) {
        this.items = items;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/entity/OrderItemEntity.java ===
package com.pragma.orders.infrastructure.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "order_items")
public class OrderItemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private OrderEntity order;

    @Column(nullable = false)
    private UUID productId;

    @Column(nullable = false)
    private String productName;

    @Column(nullable = false)
    private BigDecimal price;

    @Column(nullable = false)
    private int quantity;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public OrderEntity getOrder() {
        return order;
    }

    public void setOrder(OrderEntity order) {
        this.order = order;
    }

    public UUID getProductId() {
        return productId;
    }

    public void setProductId(UUID productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/repository/SpringDataOrderRepository.java ===
package com.pragma.orders.infrastructure.repository;

import com.pragma.orders.infrastructure.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface SpringDataOrderRepository extends JpaRepository<OrderEntity, UUID> {
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/application/service/OrderService.java ===
package com.pragma.orders.application.service;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.domain.port.OrderRepository;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public Order createOrder(UUID customerId, List<OrderItem> items) {
        if (customerId == null) {
            throw new IllegalArgumentException("Customer ID cannot be null");
        }
        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Order must contain at least one item");
        }
        
        Order order = new Order(customerId, items);
        order.setStatus(OrderStatus.PENDING);
        return orderRepository.save(order);
    }

    public Optional<Order> getOrder(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        return orderRepository.findById(orderId);
    }

    public Order updateOrder(UUID orderId, UUID customerId, List<OrderItem> items, OrderStatus status) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        
        Optional<Order> existingOrderOpt = orderRepository.findById(orderId);
        if (existingOrderOpt.isEmpty()) {
            throw new IllegalArgumentException("Order not found with id: " + orderId);
        }
        
        Order existingOrder = existingOrderOpt.get();
        
        if (customerId != null) {
            Order newOrder = new Order(customerId, items != null ? items : new ArrayList<>());
            newOrder.setStatus(status != null ? status : existingOrder.getStatus());
            newOrder.setId(orderId);
            newOrder.setCreatedAt(existingOrder.getCreatedAt());
            newOrder.setUpdatedAt(LocalDateTime.now());
            return orderRepository.save(newOrder);
        }
        
        if (status != null) {
            existingOrder.setStatus(status);
        }
        existingOrder.setUpdatedAt(LocalDateTime.now());
        return orderRepository.save(existingOrder);
    }

    public void deleteOrder(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        orderRepository.deleteById(orderId);
    }

    public BigDecimal calculateOrderTotal(List<OrderItem> items) {
        if (items == null || items.isEmpty()) {
            return BigDecimal.ZERO;
        }
        return items.stream()
            .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java ===
package com.pragma.orders.infrastructure.controller;

import com.pragma.orders.application.service.OrderService;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.infrastructure.controller.dto.OrderRequest;
import com.pragma.orders.infrastructure.controller.dto.OrderResponse;
import com.pragma.orders.infrastructure.controller.dto.OrderItemRequest;
import com.pragma.orders.infrastructure.controller.dto.OrderItemResponse;
import java.net.URI;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@RequestBody OrderRequest request) {
        List<OrderItem> items = request.getItems().stream()
            .map(this::mapToOrderItem)
            .collect(Collectors.toList());
        
        Order order = orderService.createOrder(request.getCustomerId(), items);
        OrderResponse response = mapToResponse(order);
        
        URI location = UriComponentsBuilder.fromPath("/orders/{id}")
            .buildAndExpand(response.getId())
            .toUri();
        
        return ResponseEntity.created(location).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable UUID id) {
        return orderService.getOrder(id)
            .map(order -> ResponseEntity.ok(mapToResponse(order)))
            .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderResponse> updateOrder(
            @PathVariable UUID id,
            @RequestBody OrderRequest request) {
        
        List<OrderItem> items = request.getItems() != null 
            ? request.getItems().stream()
                .map(this::mapToOrderItem)
                .collect(Collectors.toList())
            : null;
        
        OrderStatus status = request.getStatus() != null 
            ? OrderStatus.valueOf(request.getStatus()) 
            : null;
        
        try {
            Order updatedOrder = orderService.updateOrder(id, request.getCustomerId(), items, status);
            return ResponseEntity.ok(mapToResponse(updatedOrder));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable UUID id) {
        orderService.deleteOrder(id);
        return ResponseEntity.noContent().build();
    }

    private OrderItem mapToOrderItem(OrderItemRequest request) {
        OrderItem item = new OrderItem(
            request.getProductId(),
            request.getProductName(),
            request.getPrice(),
            request.getQuantity()
        );
        return item;
    }

    private OrderResponse mapToResponse(Order order) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
            .map(item -> new OrderItemResponse(
                item.getProductId(),
                item.getProductName(),
                item.getPrice(),
                item.getQuantity()
            ))
            .collect(Collectors.toList());
        
        return new OrderResponse(
            order.getId(),
            order.getCustomerId(),
            itemResponses,
            order.getStatus().name(),
            order.getTotalAmount(),
            order.getCreatedAt(),
            order.getUpdatedAt()
        );
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/config/AwsConfig.java ===
package com.pragma.orders.infrastructure.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBAsync;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBAsyncClientBuilder;
import com.amazonaws.services.sqs.AmazonSQSAsync;
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder;
import java.net.URI;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsConfig {

    @Value("${aws.access.key.id:}")
    private String accessKeyId;

    @Value("${aws.secret.access.key:}")
    private String secretAccessKey;

    @Value("${aws.region:us-east-1}")
    private String region;

    @Value("${aws.endpoint.override:}")
    private String endpointOverride;

    @Bean
    public BasicAWSCredentials awsCredentials() {
        if (accessKeyId == null || accessKeyId.isEmpty() || secretAccessKey == null || secretAccessKey.isEmpty()) {
            return null;
        }
        return new BasicAWSCredentials(accessKeyId, secretAccessKey);
    }

    @Bean
    public AmazonSQSAsync amazonSQSAsync() {
        AmazonSQSAsyncClientBuilder builder = AmazonSQSAsyncClientBuilder.standard()
            .withRegion(Regions.fromName(region));
        
        if (endpointOverride != null && !endpointOverride.isEmpty()) {
            builder.withEndpointConfiguration(
                new com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration(
                    endpointOverride,
                    region
                )
            );
        }
        
        BasicAWSCredentials credentials = awsCredentials();
        if (credentials != null) {
            builder.withCredentials(new AWSStaticCredentialsProvider(credentials));
        }
        
        return builder.build();
    }

    @Bean
    public AmazonDynamoDBAsync amazonDynamoDBAsync() {
        AmazonDynamoDBAsyncClientBuilder builder = AmazonDynamoDBAsyncClientBuilder.standard()
            .withRegion(Regions.fromName(region));
        
        if (endpointOverride != null && !endpointOverride.isEmpty()) {
            builder.withEndpointConfiguration(
                new com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration(
                    endpointOverride,
                    region
                )
            );
        }
        
        BasicAWSCredentials credentials = awsCredentials();
        if (credentials != null) {
            builder.withCredentials(new AWSStaticCredentialsProvider(credentials));
        }
        
        return builder.build();
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderRequest.java ===
package com.pragma.orders.infrastructure.controller.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;

public class OrderRequest {

    @NotNull(message = "Customer ID is required")
    private UUID customerId;

    @NotNull(message = "Items are required")
    @Valid
    private List<OrderItemRequest> items;

    private String status;

    public OrderRequest() {}

    public OrderRequest(UUID customerId, List<OrderItemRequest> items) {
        this.customerId = customerId;
        this.items = items;
    }

    public UUID getCustomerId() {
        return customerId;
    }

    public void setCustomerId(UUID customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemRequest> getItems() {
        return items;
    }

    public void setItems(List<OrderItemRequest> items) {
        this.items = items;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderItemRequest.java ===
package com.pragma.orders.infrastructure.controller.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.UUID;

public class OrderItemRequest {

    @NotNull(message = "Product ID is required")
    private UUID productId;

    @NotNull(message = "Product name is required")
    private String productName;

    @NotNull(message = "Price is required")
    @Positive(message = "Price must be positive")
    private BigDecimal price;

    @NotNull(message = "Quantity is required")
    @Positive(message = "Quantity must be positive")
    private Integer quantity;

    public OrderItemRequest() {}

    public OrderItemRequest(UUID productId, String productName, BigDecimal price, Integer quantity) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
    }

    public UUID getProductId() {
        return productId;
    }

    public void setProductId(UUID productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderResponse.java ===
package com.pragma.orders.infrastructure.controller.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class OrderResponse {

    private UUID id;
    private UUID customerId;
    private List<OrderItemResponse> items;
    private String status;
    private BigDecimal totalAmount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public OrderResponse() {}

    public OrderResponse(UUID id, UUID customerId, List<OrderItemResponse> items, 
                         String status, BigDecimal totalAmount, 
                         LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.customerId = customerId;
        this.items = items;
        this.status = status;
        this.totalAmount = totalAmount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UUID getCustomerId() {
        return customerId;
    }

    public void setCustomerId(UUID customerId) {
        this.customerId = customerId;
    }

    public List<OrderItemResponse> getItems() {
        return items;
    }

    public void setItems(List<OrderItemResponse> items) {
        this.items = items;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderItemResponse.java ===
package com.pragma.orders.infrastructure.controller.dto;

import java.math.BigDecimal;
import java.util.UUID;

public class OrderItemResponse {

    private UUID productId;
    private String productName;
    private BigDecimal price;
    private int quantity;

    public OrderItemResponse() {}

    public OrderItemResponse(UUID productId, String productName, BigDecimal price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
    }

    public UUID getProductId() {
        return productId;
    }

    public void setProductId(UUID productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

// === ARCHIVO: api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java ===
package com.pragma.orders.application.service;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.domain.port.OrderRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    private OrderRepository orderRepository;

    @InjectMocks
    private OrderService orderService;

    private Order testOrder;
    private UUID orderId;
    private UUID customerId;

    @BeforeEach
    void setUp() {
        orderId = UUID.randomUUID();
        customerId = UUID.randomUUID();

        List<OrderItem> items = new ArrayList<>();
        items.add(new OrderItem(UUID.randomUUID(), "Producto A", BigDecimal.valueOf(100), 2));
        items.add(new OrderItem(UUID.randomUUID(), "Producto B", BigDecimal.valueOf(50), 1));

        testOrder = new Order(customerId, items);
    }

    @Test
    void testCreateOrder_Success() {
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> {
            Order order = invocation.getArgument(0);
            return order;
        });

        Order result = orderService.createOrder(testOrder);

        assertNotNull(result);
        assertEquals(customerId, result.getCustomerId());
        assertEquals(OrderStatus.PENDING, result.getStatus());
        assertEquals(BigDecimal.valueOf(250), result.getTotalAmount());
        verify(orderRepository, times(1)).save(any(Order.class));
    }

    @Test
    void testCreateOrder_WithMultipleItems_CalculatesTotalCorrectly() {
        List<OrderItem> items = new ArrayList<>();
        items.add(new OrderItem(UUID.randomUUID(), "Item 1", BigDecimal.valueOf(100.50), 3));
        items.add(new OrderItem(UUID.randomUUID(), "Item 2", BigDecimal.valueOf(200.75), 2));
        items.add(new OrderItem(UUID.randomUUID(), "Item 3", BigDecimal.valueOf(50), 5));

        Order order = new Order(customerId, items);

        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Order result = orderService.createOrder(order);

        BigDecimal expectedTotal = BigDecimal.valueOf(100.50 * 3)
                .add(BigDecimal.valueOf(200.75 * 2))
                .add(BigDecimal.valueOf(50 * 5));

        assertEquals(expectedTotal.stripTrailingZeros(), result.getTotalAmount().stripTrailingZeros());
    }

    @Test
    void testGetOrderById_Found() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));

        Optional<Order> result = orderService.getOrderById(orderId);

        assertTrue(result.isPresent());
        assertEquals(orderId, result.get().getId());
        verify(orderRepository, times(1)).findById(orderId);
    }

    @Test
    void testGetOrderById_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        Optional<Order> result = orderService.getOrderById(nonExistentId);

        assertFalse(result.isPresent());
        verify(orderRepository, times(1)).findById(nonExistentId);
    }

    @Test
    void testUpdateOrder_Success() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Nuevo Producto", BigDecimal.valueOf(300), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result);
        verify(orderRepository, times(1)).findById(orderId);
        verify(orderRepository, times(1)).save(any(Order.class));
    }

    @Test
    void testUpdateOrder_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(nonExistentId, updatedOrder);

        assertNull(result);
        verify(orderRepository, times(1)).findById(nonExistentId);
        verify(orderRepository, never()).save(any(Order.class));
    }

    @Test
    void testDeleteOrder_Success() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        doNothing().when(orderRepository).deleteById(orderId);

        orderService.deleteOrder(orderId);

        verify(orderRepository, times(1)).findById(orderId);
        verify(orderRepository, times(1)).deleteById(orderId);
    }

    @Test
    void testDeleteOrder_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        orderService.deleteOrder(nonExistentId);

        verify(orderRepository, times(1)).findById(nonExistentId);
        verify(orderRepository, never()).deleteById(any(UUID.class));
    }

    @Test
    void testCreateOrder_SetsCreatedAtTimestamp() {
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Order result = orderService.createOrder(testOrder);

        assertNotNull(result.getCreatedAt());
    }

    @Test
    void testUpdateOrder_UpdatesTimestamp() {
        LocalDateTime originalTimestamp = LocalDateTime.now().minusDays(1);
        testOrder = new Order(customerId, new ArrayList<>());

        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> {
            Order order = invocation.getArgument(0);
            return order;
        });

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result.getUpdatedAt());
    }

    @Test
    void testCreateOrder_WithEmptyItems_ThrowsException() {
        Order emptyOrder = new Order(customerId, new ArrayList<>());

        when(orderRepository.save(any(Order.class))).thenThrow(new IllegalArgumentException("La orden debe contener al menos un artículo"));

        assertThrows(IllegalArgumentException.class, () -> {
            orderService.createOrder(emptyOrder);
        });
    }

    @Test
    void testUpdateOrder_ChangesStatus() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result.getStatus());
    }
}
```
