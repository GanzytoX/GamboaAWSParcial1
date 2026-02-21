# Tarea 1 - Máquinas Virtuales

Este repositorio contiene el código Terraform para crear una máquina virtual EC2 en AWS, expuesta a internet en el puerto 80, mostrando un sitio web demo. La infraestructura incluye:

- VPC con al menos una subnet pública
- Security group para acceso HTTP y SSH
- Instancia EC2 con Apache instalado automáticamente
- Sitio demo automatizado

## Instrucciones de uso

1. Instala Terraform y AWS CLI.
2. Configura tus credenciales AWS (`aws configure`).
3. Ve a la carpeta `tarea1`.
4. Ejecuta:
   - `terraform init`
   - `terraform apply` (confirma con `yes`)
5. Al finalizar, abre la URL mostrada en la salida para ver el sitio demo.
6. Para destruir la infraestructura y evitar cobros:
   - `terraform destroy` (confirma con `yes`)

---
**Autor:** Gonzalo Gamboa
