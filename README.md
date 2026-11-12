<div align="center">
  <img src="URL_DEL_LOGO_AQUI" alt="Apptiva Paseo-Perro Logo" width="150"/>
  <h1>Apptiva Paseo-Perro</h1>
  <p>Una aplicación sencilla y eficaz para registrar y consultar los paseos del perro familiar, asegurando que todos en casa sepan cuándo fue la última vez que salió.</p>
  
  <!-- Badges -->
  <p>
    <a href="https://github.com/motercode/apptiva-paseo-perro/actions/workflows/deploy-web.yml"><img src="https://github.com/motercode/apptiva-paseo-perro/actions/workflows/deploy-web.yml/badge.svg" alt="Deploy Web"></a>
    <a href="https://github.com/motercode/apptiva-paseo-perro/actions/workflows/deploy-android.yml"><img src="https://github.com/motercode/apptiva-paseo-perro/actions/workflows/deploy-android.yml/badge.svg" alt="Deploy Android"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
  </p>
</div>

---

## ✨ Características

*   �� **Registro de Paseos:** Añade un nuevo paseo con un solo toque.
*   🕒 **Historial de Paseos:** Consulta la lista de los últimos paseos realizados.
*   👨‍👩‍👧‍👦 **Sincronización Familiar:** (Próximamente) Comparte el historial con los miembros de tu hogar.
*   🤖 **Integración con IA:** (Próximamente) Usa Gemini para obtener resúmenes o sugerencias.

---

## 🚀 Guía de Inicio Rápido

Para empezar a trabajar en el proyecto, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/motercode/apptiva-paseo-perro.git
    cd apptiva-paseo-perro
    ```

2.  **Instala las dependencias:**
    ```bash
    flutter pub get
    ```

3.  **Ejecuta la aplicación:**
    ```bash
    flutter run
    ```

---

## 🛠️ Tecnologías Utilizadas

*   **Framework:** [Flutter](https://flutter.dev/)
*   **Lenguaje:** [Dart](https://dart.dev/)
*   **Arquitectura:** Clean Architecture
*   **CI/CD:** GitHub Actions
*   **Backend & Hosting:** Firebase (Hosting, App Distribution)
*   **APIs:** Google Gemini

---

## 🏗️ Arquitectura y Estructura del Proyecto

Este proyecto sigue los principios de **Clean Architecture**. El código está organizado por funcionalidades (`features`) para mantenerlo desacoplado, mantenible y fácil de testear.

```
lib/
├─��� app/                  # Configuración principal de la app
├── features/
│   └── walks/            # Funcionalidad de "Paseos"
│       ├── data/         # Fuentes de datos (API, DB local)
│       ├── domain/       # Lógica de negocio (Casos de Uso, Repositorios)
│       └── presentation/ # UI y Estado (Widgets, BLoCs/Providers)
└── main.dart             # Punto de entrada de la aplicación
```

---

## 🤝 Cómo Contribuir

Seguimos un flujo de trabajo profesional para asegurar la calidad y la trazabilidad del código.

1.  **Issues:** Todo trabajo comienza con un `Issue` en GitHub.
2.  **Branches:** Se crea una rama a partir de `main` (`feature/HU-4-nombre-feature`).
3.  **Commits:** Usamos **Conventional Commits** (`feat(walks):`, `fix(auth):`).
4.  **Pull Requests (PRs):** Al finalizar, se abre un PR contra `main` para su revisión.

---

## ☁️ Despliegue de Pre-producción (CI/CD)

El proyecto usa GitHub Actions y Firebase para el despliegue continuo. Cada merge a `main` dispara los despliegues.

*   **Aplicación Web:** **[https://apptiva-paseo-perro-pre.web.app](https://apptiva-paseo-perro-pre.web.app)**
*   **Aplicación Android:** Se distribuye al grupo de testers `testers-preproduccion` vía Firebase App Distribution.

---

## 💰 Costos y Facturación (Google Cloud)

Este proyecto utiliza una clave de API para Google Gemini, configurada en el archivo `.env`.

**Actualmente, el proyecto NO genera ningún costo.**

El proyecto de Google Cloud no está vinculado a una cuenta de facturación. Si la API de Gemini deja de funcionar, es probable que se haya excedido la capa gratuita y se necesite vincular una cuenta de facturación en la Consola de Google Cloud.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
