# Reinstalación — projects/apptiva-paseo-perro/android

> Se borraron dependencias y artefactos regenerables para liberar espacio. Aquí está cómo recomponerlo.

## Limpieza del 2026-11-07

**Borrado:**
- `.gradle/` (Gradle)

**Cómo recomponerlo:**

### Gradle 8.12 (wrapper)
```powershell
.\gradlew.bat assembleDebug      # descarga Gradle y dependencias
```
Requiere JDK y, si es Android, el SDK indicado en local.properties.
