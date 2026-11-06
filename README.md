# Aprovisionamiento de Infraestructura con Terraform para el Servicio de Órdenes

El equipo de desarrollo necesita aprovisionar la infraestructura AWS para el servicio de órdenes utilizando Terraform. El objetivo es versionar la infraestructura del servicio para asegurar su consistencia y replicabilidad en diferentes entornos. Los actores involucrados son el equipo de desarrollo, el equipo de operaciones y los usuarios del servicio de órdenes. La infraestructura debe soportar un volumen pico de 10,000 órdenes por hora con una disponibilidad del 99.9%.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración Inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para aprovisionar la infraestructura AWS.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar las dependencias necesarias para ejecutar Terraform.
- Configurar el archivo de configuración de Terraform para autenticarse en AWS.
- Verificar que el entorno esté correctamente configurado ejecutando un comando de inicialización de Terraform.

**Entregable:** Entorno de Terraform configurado y autenticado en AWS.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de variables de entorno para almacenar credenciales.
- Ejecución de comandos de Terraform en la línea de comandos.

</details>

### Fase 2: Definición de Recursos de Infraestructura

**Objetivo:** Definir los recursos de infraestructura necesarios para el servicio de órdenes en Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Identificar los recursos de AWS necesarios para el servicio de órdenes (ej. EC2, RDS, S3).
- Definir estos recursos en el archivo de configuración de Terraform.
- Verificar la sintaxis y la correcta definición de los recursos.

**Entregable:** Archivo de configuración de Terraform con los recursos de infraestructura definidos.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de módulos de Terraform para reutilizar configuraciones.
- Definición de recursos con propiedades y dependencias.

</details>

### Fase 3: Aprovisionamiento y Verificación de Infraestructura

**Objetivo:** Aprovisionar la infraestructura definida en Terraform y verificar su correcto funcionamiento.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Ejecutar el comando de Terraform para aprovisionar la infraestructura.
- Verificar que los recursos se han creado correctamente en AWS.
- Realizar pruebas de carga para asegurar que la infraestructura soporta el volumen pico de órdenes.

**Entregable:** Infraestructura aprovisionada y verificada en AWS.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de comandos de Terraform para aplicar y destruir la infraestructura.
- Herramientas de pruebas de carga para verificar la capacidad de la infraestructura.
- Java: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en este contexto?
- **paraQueSirve**: ¿Para qué sirve versionar la infraestructura del servicio de órdenes?
- **comoSeUsa**: ¿Cómo se usa Terraform para definir y aprovisionar recursos de infraestructura?
- **erroresComunes**: ¿Cuáles son los errores comunes al configurar y aprovisionar infraestructura con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones implica el aprovisionamiento de infraestructura para el servicio de órdenes?

## Criterios de Evaluacion

- Configuración inicial de Terraform.
- Definición de recursos de infraestructura en Terraform.
- Aprovisionamiento y verificación de la infraestructura en AWS.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
