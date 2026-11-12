# Entorno, móvil de pruebas y depuración

## Entorno de compilación

- **JDK 17 completo** (con `jlink`; AGP lo usa para compilar contra el SDK). Si el Java del sistema no
  sirve, instala un Temurin 17 en el usuario (p. ej. `~/.local/jdk-17`) y
  `export JAVA_HOME=~/.local/jdk-17` antes de `./gradlew`.
- **Android SDK** sin Android Studio, con `cmdline-tools`:
  ```bash
  sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
  ```
  `local.properties` (no versionado) con `sdk.dir=<ruta>`: cada máquina el suyo.
- **Secretos de depuración** (p. ej. el PIN del modo UIX, `uix.debug.pin`): también en
  `local.properties`, o en una variable de entorno (`UIX_DEBUG_PIN`) en CI. `app/build.gradle.kts`
  los lee y los inyecta con `buildConfigField` **solo en `debug`**; en `release` quedan vacíos.
  Sin valor, la función que protegen no se puede activar.

## Móvil de pruebas

- Usa un móvil **de pruebas**, nunca el del usuario final con sus datos reales.
- Anota en la guía del proyecto su modelo, versión de Android, resolución y densidad: son la
  referencia de las capturas.

### Conectar por Wi-Fi (depuración inalámbrica, Android 11+)

1. Móvil: Opciones de desarrollador → Depuración inalámbrica → **Vincular con código**.
2. `adb pair <ip>:<puerto-de-vinculación> <código>` (el puerto de vinculación **no** es el de conexión).
3. `adb connect <ip>:<puerto-de-conexión>` (el de la pantalla principal de Depuración inalámbrica).
4. El emparejamiento se conserva; el puerto de conexión cambia cada vez que se reactiva la depuración.
   `adb mdns services` muestra los servicios anunciados.

**Si `adb pair` da `protocol fault` o `No route to host`** aunque `adb mdns services` vea el móvil: el
móvil no responde a las peticiones ARP del PC (el ping falla, `ip neigh` muestra `INCOMPLETE`). Haz que
el móvil hable primero con el PC (p. ej. abrir en su navegador una página servida por el PC con
`python3 -m http.server`) y, cuando `ip neigh` muestre su MAC como `REACHABLE`, repite. Un
`ping -i 2 <ip>` en segundo plano mantiene la entrada viva.

### Antes de lanzar tests o capturas

- Pantalla encendida y **desbloqueada** (un PIN no se puede quitar por adb). Para que no se apague:
  ```bash
  adb shell settings get system screen_off_timeout          # guarda el valor
  adb shell settings put system screen_off_timeout 1800000  # 30 min; restáuralo al terminar (trap)
  adb shell input keyevent KEYCODE_WAKEUP; adb shell wm dismiss-keyguard
  ```
- Sin "No molestar" ni modo sueño; sin otra app a pantalla completa.
- Si `adb install` da `INSTALL_FAILED_UPDATE_INCOMPATIBLE`, la app instalada está firmada con la clave
  debug de otro PC: copia su `~/.android/debug.keystore` o desinstala (borra los datos de la app).

## Logs

- En vivo: `adb logcat -s <Etiqueta1> <Etiqueta2>`; usa un prefijo común en las etiquetas
  (`<App>OCR`, `<App>UI`…) para filtrar.
- Persistente: el log de debug en `files/logs/` (ver [privacidad-y-logs.md](privacidad-y-logs.md)).
  Leerlo por adb (solo APK debug):
  `adb exec-out run-as <app-id> cat files/logs/<app>-debug.log`.

## Datos de la app (solo debug)

`run-as` funciona con APK depurables:
```bash
adb exec-out "run-as <app-id> tar -cf - databases files" | tar -xf - -C <destino>
```
Para sacar ficheros generados por los tests instrumentados (p. ej. capturas), guárdalos en
`filesDir` y descárgalos así: no hacen falta permisos de almacenamiento.

## MCP del móvil para agentes (Claude Code)

`mobile-mcp` deja a un agente ver y manejar el móvil:
```bash
claude mcp add mobile-mcp -s local -e ANDROID_HOME=$HOME/Android/Sdk -- npx -y @mobilenext/mobile-mcp@1.0.13
```
- `mobile_list_available_devices` → usar el id `IP:puerto` en cada llamada.
- `mobile_launch_app` con `<app-id>`.
- `mobile_list_elements_on_screen` (textos, posiciones y tamaños): mejor que las capturas.
- `mobile_take_screenshot`, `mobile_click_on_screen_at_coordinates`, `mobile_swipe_on_screen`,
  `mobile_batch_commands` para secuencias.
- Actúa sobre la app instalada y sus datos: no pulses acciones que lean datos personales del móvil
  (agenda, fotos) sin permiso del dueño.
- Quitarlo: `claude mcp remove mobile-mcp -s local`.

## Extensiones útiles

- **Roborazzi** (capturas JVM) y el **MCP** anterior.
- `scrcpy` para ver y manejar el móvil desde el PC.
