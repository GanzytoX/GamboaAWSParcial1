import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get()
  getRoot(): string {
    return `
      <!DOCTYPE html>
      <html lang="es">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Examen Gonzalo Gamboa</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <style>
          body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
          }
          .container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.06);
            padding: 48px 32px;
            max-width: 400px;
            width: 100%;
            text-align: center;
          }
          h1 {
            font-weight: 700;
            color: #0063ff;
            margin-bottom: 12px;
            font-size: 2rem;
          }
          .subtitle {
            color: #222;
            font-size: 1rem;
            margin-bottom: 0;
            font-weight: 400;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>¡Bienvenido al Examen!</h1>
          <div class="subtitle">Gonzalo Gamboa &mdash; NestJS + Minimal UI</div>
        </div>
      </body>
      </html>
    `;
  }
}
