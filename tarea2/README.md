# Tarea 2 - Fargate

Este repositorio contiene el código Terraform para crear una arquitectura DMZ en AWS, un registro ECR para almacenar imágenes de contenedores y exponer una aplicación a través de un balanceador de carga usando ECS Fargate.

La infraestructura incluye:
- VPC con subnets pública (DMZ) y privada
- Repositorio ECR
- Application Load Balancer (ALB)
- Cluster ECS Fargate
- Servicio ECS para desplegar la aplicación

## Instrucciones de uso

1. Instala Terraform y AWS CLI.
2. Configura tus credenciales AWS (`aws configure`).
3. Ve a la carpeta `tarea2`.
4. Ejecuta:
   - `terraform init`
   - `terraform apply` (confirma con `yes`)
5. Sube tu imagen de contenedor a ECR o usa una imagen pública.
6. Modifica el valor de `container_image` en `variables.tf` para usar la imagen deseada.
7. Al finalizar, abre el DNS del ALB mostrado en la salida para acceder a la aplicación.
8. Para destruir la infraestructura y evitar cobros:
   - `terraform destroy` (confirma con `yes`)

---
**Autor:** Gonzalo Gamboa
