# AGENTS.md

Punto de entrada para agentes de IA (Claude Code, Gemini, Codex, Copilot…) y personas nuevas en
Apptiva Paseo-Perro: una app Flutter para registrar y consultar los paseos del perro familiar.

**Lee primero:**
- [README.md](README.md): qué hace la app, arquitectura y despliegue.
- [FlutterDev_GEMINI.md](FlutterDev_GEMINI.md): cómo trabaja el agente desarrollador (TDD y tareas
  desde la checklist del issue).
- [docs/agentes/plantilla/README.md](docs/agentes/plantilla/README.md): prácticas comunes traídas de
  ConserjeCV y qué vale de cada una en Flutter.

## Reglas que no se pueden saltar

1. **Ni secretos ni datos reales en git.** Claves de API, tokens de Firebase, `.env`, ficheros de
   cuentas de servicio y datos de la familia (paseos reales, nombres, fotos) se quedan fuera del
   repositorio. Los secretos del CI van en *Settings → Secrets and variables → Actions*.
   → [privacidad-y-logs.md](docs/agentes/plantilla/privacidad-y-logs.md)
2. **TDD.** Ninguna línea de producción sin una prueba que falle antes (rojo → verde → refactor).
   Si cambia el código, cambian sus tests.
3. **Antes de cada commit y de cada PR:** `flutter analyze` sin avisos y `flutter test` en verde. La
   salida va en el PR como evidencia. Los tests existentes no se borran.
4. **Commits en inglés** con Conventional Commits y el issue al final:
   `feat(walks): record a walk with one tap (#1)`. Comentarios, UI, docs, issues y títulos de PR en
   español. → [flujo-de-trabajo.md](docs/agentes/plantilla/flujo-de-trabajo.md)
5. **Dónde va cada decisión:** producto y alcance → issue; implementación → PR; arquitectura y
   proceso → `ADR.md` (arrancar con [adr-base.md](docs/agentes/plantilla/adr-base.md)).

## Ciclo de un cambio

1. Issue con el contexto (o la checklist de tareas de una historia de usuario).
2. Rama desde `main`: `tipo/issue-N-descripcion-corta` (`feat/issue-4-sincronizacion-familiar`).
   Las tareas de una historia van en `task/<nombre-corto>` contra la rama de la feature.
3. Test que falla → código → refactor.
4. `flutter analyze` y `flutter test`.
5. PR con la plantilla de `.github/pull_request_template.md`. Cada merge a `main` despliega la web de
   preproducción y el APK a los testers de Firebase App Distribution.

## Arquitectura

Clean Architecture por funcionalidades:

```
lib/
├── app/                      # configuración de la app
├── features/<funcionalidad>/
│   ├── data/                 # fuentes de datos (sqflite) y repositorios concretos
│   ├── domain/               # modelos, casos de uso y contratos
│   └── presentation/         # pantallas y estado
└── main.dart
test/                         # misma estructura que lib/
```

Los datos de los paseos se guardan en local con `sqflite`; Firebase solo aloja la web y distribuye el APK.

## Comandos

```bash
flutter pub get                               # dependencias
flutter analyze                               # lint (flutter_lints)
flutter test                                  # unitarios y de widgets
dart run build_runner build --delete-conflicting-outputs   # regenerar los mocks de mockito
flutter run -d <dispositivo>                  # ejecutar (adb por Wi-Fi: docs/agentes/plantilla/entorno-y-dispositivo.md)
flutter build apk --release                   # el mismo build que hace el CI
```

## Mantener esta guía

Si descubres una convención, un truco o una trampa nueva, añádela aquí o en `docs/agentes/` en el
mismo PR. Si una regla cambia, cámbiala primero en el README o en el ADR y luego aquí.
