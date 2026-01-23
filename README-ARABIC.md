# 🚀 No-Code Architects Toolkit API - Versión con Fuentes Árabes

**Fork personalizado de [stephengpope/no-code-architects-toolkit](https://github.com/stephengpope/no-code-architects-toolkit)**

Esta versión incluye **soporte completo para fuentes árabes y renderizado RTL (Right-to-Left)** para subtítulos y procesamiento de video.

## ✨ Características Adicionales

### 🎯 **Fuentes Árabes Incluidas**
- ✅ **Amiri** - Fuente clásica árabe con excelente legibilidad
- ✅ **Cairo** - Moderna y profesional
- ✅ **Tajawal** - Perfecta para interfaces
- ✅ **Almarai** - Contemporánea y elegante
- ✅ **Scheherazade New** - Tradicional con toques modernos
- ✅ **Noto Sans Arabic** - Compatibilidad universal

### 🔄 **Soporte RTL Completo**
- Detección automática de texto árabe
- Renderizado de derecha a izquierda
- Resaltado secuencial correcto en RTL
- Auto-detección de fuentes árabes

### 🐳 **Deploy Fácil**
```bash
# Deploy desde tu fork
./deploy-from-fork.sh

# O deploy desde Docker
docker build -t nca-arabic:latest .
docker run -p 8080:8080 nca-arabic:latest
```

## 📋 **Cómo Usar**

### API Endpoint con Fuentes Árabes
```bash
curl -X POST https://tu-url.cloud.run/v1/video/caption \
  -H "X-API-Key: tu_api_key" \
  -H "Content-Type: application/json" \
  -d '{
    "video_url": "url_de_tu_video",
    "subtitles": [
      {
        "text": "مرحبا بالعالم العربي",
        "start": "00:00:00",
        "end": "00:00:05",
        "font": "Amiri",
        "rtl": true
      }
    ]
  }'
```

## 🔧 **Deployment Options**

### Opción 1: Google Cloud Run (Recomendado)
```bash
./deploy-from-fork.sh
```

### Opción 2: Docker Local
```bash
docker-compose -f docker-compose.arabic.yml up --build
```

### Opción 3: Deploy Manual
Sigue las instrucciones en `INSTRUCCIONES_DEPLOY_ARABIC.md`

## 📁 **Estructura del Proyecto**

```
├── fonts/                 # 🎨 27 fuentes árabes TTF
├── routes/v1/video/       # 🔄 Endpoints modificados para RTL
├── services/             # ⚙️ Servicios con soporte árabe
├── docker-compose.arabic.yml    # 🐳 Compose para testing
├── deploy-from-fork.sh          # 🚀 Script de deploy
└── INSTRUCCIONES_DEPLOY_ARABIC.md # 📖 Guía completa
```

## 🔄 **Mantener Sincronizado**

Para actualizar con cambios del repositorio original:

```bash
# Ver qué hay nuevo
./check-upstream-updates.sh

# Mergear cambios (opcional)
./merge-upstream.sh
```

## 🎯 **Diferencias con el Original**

Esta versión incluye:
- ✅ **27 fuentes árabes** en `/fonts/`
- ✅ **Soporte RTL** en `services/ass_toolkit.py`
- ✅ **Auto-detección árabe** en `services/caption_video.py`
- ✅ **Scripts de deploy** personalizados
- ✅ **Documentación en español**

## 📞 **Soporte**

Este es un fork mantenido por [gneuman](https://github.com/gneuman).
Para soporte del toolkit original, visita [No-Code Architects Community](https://www.skool.com/no-code-architects).

---

## 📄 **README Original**

Para la documentación completa del toolkit original, ver [README.md](README.md).