# Examen - NestJS + Pipeline

Este repositorio contiene una aplicación básica desarrollada con NestJS y un pipeline de GitHub Actions para automatizar el despliegue en AWS ECS Fargate (infraestructura de la Tarea 2).

## Estructura

- Aplicación NestJS (src/)
- Dockerfile listo para producción
- Pipeline GitHub Actions en `.github/workflows/deploy.yml`

## Instrucciones de uso

1. Instala dependencias:
   - `npm install`
2. Compila la app:
   - `npm run build`
3. Ejecuta localmente:
   - `npm start`
   - Abre [http://localhost:80](http://localhost:80) para ver la app
4. Para construir y probar con Docker:
   - `docker build -t examen-nestjs-gg .`
   - `docker run -p 80:80 examen-nestjs-gg`
5. El pipeline de GitHub Actions construye la imagen, la sube a ECR y actualiza el servicio ECS Fargate automáticamente.

## Notas
- La app muestra un mensaje de bienvenida con diseño minimalista y la tipografía Inter.
- Modifica el pipeline y los secretos de GitHub según tu infraestructura.

---
**Autor:** Gonzalo Gamboa
