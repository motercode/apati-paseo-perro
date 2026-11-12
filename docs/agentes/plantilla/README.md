# Prácticas comunes traídas de ConserjeCV

Guías copiadas el 2026-11-12 de `ConserjeCV/docs/agentes/plantilla/`, la plantilla de prácticas
independientes del negocio de ConserjeCV. Allí están escritas para una app **Android nativa**
(Kotlin + Compose + Room, sin backend); este proyecto es **Flutter + Firebase**, así que se aplican
con estas salvedades:

| Guía | Qué vale aquí | Qué no vale o hay que traducir |
|---|---|---|
| [flujo-de-trabajo.md](flujo-de-trabajo.md) | Ciclo issue → rama → tests → PR con evidencia → ADR; Conventional Commits en inglés con `(#issue)`; idioma por tipo de texto; criterio «plantilla o negocio» | `./gradlew testDebugUnitTest lintDebug` y `scripts/e2e.sh` → `flutter analyze` y `flutter test`; KDoc → comentarios `///` de Dart |
| [adr-base.md](adr-base.md) | ADR-0002 (dónde va cada decisión), ADR-0003 (calidad antes de cada PR), ADR-0004 (tests sobre datos semilla aislados), registro de decisiones operativas | ADR-0001 (Kotlin/Compose/Room), ADR-0005 (R8), ADR-0006 (Room) y ADR-0007 (solo local: esta app usa Firebase) |
| [privacidad-y-logs.md](privacidad-y-logs.md) | Datos reales y secretos fuera de git, datos ficticios para pruebas, logs solo en debug, cuidado con agentes y datos reales | `DebugLog` y R8 → `kDebugMode`/`debugPrint` y la ofuscación de Flutter |
| [entorno-y-dispositivo.md](entorno-y-dispositivo.md) | Móvil de pruebas por adb Wi-Fi, logs con `adb logcat`, MCP del móvil para agentes | JDK y `cmdline-tools` los gestiona `flutter doctor`; `run-as` sigue valiendo para Android |

No se han copiado `tests.md`, `capturas-ui.md`, `trampas-android.md`, `uix-debug.md` ni
`arquitectura-base.md`: son de Compose, Robolectric/Roborazzi, Room y Gradle.

La guía del agente desarrollador de este proyecto sigue siendo [FlutterDev_GEMINI.md](../../../FlutterDev_GEMINI.md).
