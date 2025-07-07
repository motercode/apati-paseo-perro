# apati-paseo-perro
una app para controlar los paseos del perro familiar

---

## Despliegue de Pre-producción (CI/CD)

Este proyecto está configurado con un sistema de Integración y Despliegue Continuo (CI/CD) a través de GitHub Actions y Firebase.

### Proceso

Cada vez que se fusiona un cambio en la rama `main`, se activan automáticamente dos flujos de trabajo (workflows):

1.  **Despliegue Web:** Compila la versión web de la aplicación y la despliega en Firebase Hosting.
2.  **Despliegue Android:** Compila la versión de Android (APK) y la distribuye a través de Firebase App Distribution.

### Acceso a las Versiones de Pre-producción

*   **Aplicación Web:**
    *   La versión más reciente está siempre disponible en la siguiente URL:
    *   **[https://apati-paseo-perro-pre.web.app](https://apati-paseo-perro-pre.web.app)**

*   **Aplicación Android:**
    *   Las nuevas versiones se envían al grupo de testers `testers-preproduccion`.
    *   Los miembros de este grupo recibirán una notificación por correo electrónico con un enlace para descargar e instalar el APK.