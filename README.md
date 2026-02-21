# GamboaAWSParcial1

Este repositorio contiene tres carpetas:
- tarea1: Infraestructura de máquina virtual EC2 con sitio web demo.
- tarea2: Infraestructura con arquitectura DMZ, ECR y ECS Fargate.
- Examen: Aplicación NestJS y pipeline de GitHub Actions para despliegue automático en ECS Fargate.

## Estructura

- Cada carpeta tiene su propio README con instrucciones específicas.
- El archivo .gitignore en la raíz excluye archivos innecesarios de todas las carpetas.

## Uso de GitHub Secrets

Para el pipeline de GitHub Actions (Examen), debes configurar los siguientes secretos en tu repositorio de GitHub:

1. Ve a tu repositorio en GitHub.
2. Haz clic en "Settings" (Configuración).
3. En el menú lateral, selecciona "Secrets and variables" > "Actions".
4. Haz clic en "New repository secret" y agrega cada uno:

- `AWS_ACCESS_KEY_ID`: Tu Access Key de AWS
- `AWS_SECRET_ACCESS_KEY`: Tu Secret Key de AWS
- `ECR_REPOSITORY`: URI del repositorio ECR (ejemplo: 123456789012.dkr.ecr.us-east-1.amazonaws.com/demo-app-gg)
- `ECS_CLUSTER`: Nombre del cluster ECS (ejemplo: tarea2-cluster-gg)
- `ECS_SERVICE`: Nombre del servicio ECS (ejemplo: demo-app-gg)
- `TASK_DEFINITION`: Nombre de la definición de tarea ECS (ejemplo: demo-app-gg)

Estos secretos permiten que el pipeline construya la imagen, la suba a ECR y actualice el servicio ECS Fargate de forma segura.

---
**Autor:** Gonzalo Gamboa
