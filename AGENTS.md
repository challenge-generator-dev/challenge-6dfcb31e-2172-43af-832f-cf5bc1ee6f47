# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Aprovisionamiento de Infraestructura con Terraform para el Servicio de Órdenes**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el servicio de ordenes |
| Nivel | senior-l2 |
| Chapter | Backend |
| Especialidad | Java |
| Stack | Java / Spring Boot 3.5 |
| Patron arquitectonico | capas estándar con separación de dominio e infraestructura |
| Tiempo estimado | 8 horas |

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

## Receta del stack

Esqueleto obligatorio:

- `pom.xml en la raiz`
- `clase con @SpringBootApplication`
- `application.yml en src/main/resources`
- `capa de dominio con entidades y puertos`
- `capa de aplicacion con casos de uso`
- `capa de infraestructura con adaptadores y @RestController`

Trampas conocidas:

- TODA `<version>` del pom va con tres segmentos: la del parent (ej. `3.5.6`) y la de cada dependencia que la lleve (ej. Resilience4j `2.2.0`). `3.4` y `2.0` no existen como artefacto y el build muere resolviendo dependencias.
- Las dependencias que el parent POM gestiona van SIN `<version>`: `spring-boot-starter-web`, `-data-jpa`, `-validation`, `-test`, etc.
- Resilience4j publica un artefacto por linea de Spring Boot. Con Spring Boot 3 va `resilience4j-spring-boot3` con version de tres segmentos (ej. `2.2.0`, no `2.0`). `resilience4j-spring-boot2` es de Spring Boot 2 y rompe el arranque.
- Si usas anotaciones de validacion (`@NotNull`, `@Size`, `@Positive`) declara `spring-boot-starter-validation`: el starter web no las trae.
- El `spring-boot-maven-plugin` tiene que estar en `<build><plugins>` o no se empaqueta ejecutable.
- Spring Boot 3 usa `jakarta.*`, nunca `javax.*`.
- Cada archivo empieza con su `package` y con un `import` por cada clase del proyecto que viva en otro paquete. Usar `PaymentService` desde `infrastructure` sin `import com.x.application.PaymentService` no compila.

Dependencias:

- org.springframework.boot:spring-boot-starter-web n/a
- org.springframework.boot:spring-boot-starter-data-jpa n/a
- org.springframework.boot:spring-boot-starter-validation n/a
- org.springframework.boot:spring-boot-starter-actuator n/a
- com.amazonaws:aws-java-sdk-sqs 1.12.760
- com.amazonaws:aws-java-sdk-dynamodb 1.12.760
- org.postgresql:postgresql 42.7.3
- org.springframework.boot:spring-boot-starter-test n/a

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración Inicial de Terraform**: Entorno de Terraform configurado y autenticado en AWS.
- **Fase 2 — Definición de Recursos de Infraestructura**: Archivo de configuración de Terraform con los recursos de infraestructura definidos.
- **Fase 3 — Aprovisionamiento y Verificación de Infraestructura**: Infraestructura aprovisionada y verificada en AWS.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/orders_service/ecs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/orders_service/rds.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/orders_service/alb.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/orders_service/s3.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/orders_service/cloudwatch.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/envs/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/envs/dev/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/envs/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/envs/prod/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Referencias colgando (13)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setId`
      Se invoca `setId` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setCreatedAt`
      Se invoca `setCreatedAt` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `Order.setUpdatedAt`
      Se invoca `setUpdatedAt` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getItems`
      Se invoca `getItems` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getCustomerId`
      Se invoca `getCustomerId` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItemRequest.getStatus`
      Se invoca `getStatus` sobre `OrderItemRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getProductId`
      Se invoca `getProductId` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getProductName`
      Se invoca `getProductName` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getPrice`
      Se invoca `getPrice` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java` — `OrderItem.getQuantity`
      Se invoca `getQuantity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `OrderService.getOrderById`
      Se invoca `getOrderById` sobre `OrderService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `Order.isPresent`
      Se invoca `isPresent` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java` — `Order.get`
      Se invoca `get` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (33)

- `infra/environments/dev/terraform.tfvars`
- `infra/providers.tf`
- `infra/variables.tf`
- `infra/envs/dev/variables.tf`
- `infra/envs/prod/variables.tf`
- `infra/versions.tf`
- `infra/main.tf`
- `infra/outputs.tf`
- `infra/README.md`
- `infra/modules/orders_service/ecs.tf`
- `infra/modules/orders_service/rds.tf`
- `infra/modules/orders_service/alb.tf`
- `infra/modules/orders_service/s3.tf`
- `infra/modules/orders_service/cloudwatch.tf`
- `infra/envs/dev/main.tf`
- `infra/envs/prod/main.tf`
- `api/pom.xml`
- `api/src/main/java/com/pragma/orders/Application.java`
- `api/src/main/resources/application.yml`
- `api/src/main/java/com/pragma/orders/domain/model/Order.java`
- `api/src/main/java/com/pragma/orders/domain/port/OrderRepository.java`
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java`
- `api/src/main/java/com/pragma/orders/infrastructure/entity/OrderEntity.java`
- `api/src/main/java/com/pragma/orders/infrastructure/entity/OrderItemEntity.java`
- `api/src/main/java/com/pragma/orders/infrastructure/repository/SpringDataOrderRepository.java`
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java`
- `api/src/main/java/com/pragma/orders/infrastructure/controller/OrderController.java`
- `api/src/main/java/com/pragma/orders/infrastructure/config/AwsConfig.java`
- `api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderRequest.java`
- `api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderItemRequest.java`
- `api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderResponse.java`
- `api/src/main/java/com/pragma/orders/infrastructure/controller/dto/OrderItemResponse.java`
- `api/src/test/java/com/pragma/orders/application/service/OrderServiceTest.java`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `infra`
- `infra/modules/orders_service`
- `infra/envs/dev`
- `infra/envs/prod`
- `api`
- `api/src/main/java/com/pragma/orders`
- `api/src/main/resources`
- `api/src/test/java/com/pragma/orders`

## Verificacion

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **capas estándar con separación de dominio e infraestructura**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform (corrida e2e 20261106172943501), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes
- Mision: Versionar la infraestructura del servicio

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
