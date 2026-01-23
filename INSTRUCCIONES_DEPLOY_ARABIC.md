# 🚀 Deploy de NCA Toolkit con Fuentes Árabes a Google Cloud Run

## Paso 1: Preparar tu entorno

Asegúrate de tener instalados y configurados:
- Docker Desktop (corriendo)
- Google Cloud SDK (`gcloud`)
- Autenticación con Google Cloud (`gcloud auth login`)

## Paso 2: Configurar el proyecto de Google Cloud

```bash
# Establecer el proyecto
gcloud config set project TU_PROJECT_ID

# Habilitar APIs necesarias
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

## Paso 3: Construir y subir la imagen

```bash
# Construir imagen con fuentes árabes
docker build -t nca-toolkit-arabic:latest .

# Taggear para GCR
docker tag nca-toolkit-arabic:latest gcr.io/TU_PROJECT_ID/nca-toolkit-arabic:latest

# Subir a Google Container Registry
docker push gcr.io/TU_PROJECT_ID/nca-toolkit-arabic:latest
```

## Paso 4: Deploy a Cloud Run

```bash
gcloud run deploy nca-toolkit-arabic \
  --image gcr.io/TU_PROJECT_ID/nca-toolkit-arabic:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars "API_KEY=TU_API_KEY_SECRETA" \
  --set-env-vars "GCP_SA_CREDENTIALS=TU_SERVICE_ACCOUNT_JSON" \
  --set-env-vars "GCP_BUCKET_NAME=TU_BUCKET_NAME" \
  --memory 2Gi \
  --cpu 1 \
  --max-instances 10 \
  --timeout 300
```

## Paso 5: Verificar el deployment

```bash
# Obtener la URL del servicio
gcloud run services describe nca-toolkit-arabic \
  --region us-central1 \
  --format "value(status.url)"
```

## Configuración de Variables de Entorno

### Requeridas:
- `API_KEY`: Tu clave de API secreta para autenticación
- `GCP_SA_CREDENTIALS`: JSON completo de tu Service Account de GCP
- `GCP_BUCKET_NAME`: Nombre de tu bucket de Google Cloud Storage

### Opcionales:
- `LOCAL_STORAGE_PATH`: Directorio temporal (default: /tmp)
- `MAX_QUEUE_LENGTH`: Máximo jobs concurrentes (default: 0 = ilimitado)
- `GUNICORN_WORKERS`: Número de workers (default: CPUs + 1)

## 🧪 Probar las fuentes árabes

Una vez desplegado, puedes probar el endpoint de caption con fuentes árabes:

```bash
curl -X POST https://TU_URL/v1/video/caption \
  -H "X-API-Key: TU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "video_url": "URL_DE_TU_VIDEO",
    "subtitles": [
      {
        "text": "مرحبا بالعالم",
        "start": "00:00:00",
        "end": "00:00:05",
        "font": "Amiri",
        "rtl": true
      }
    ]
  }'
```

## 📝 Notas importantes

1. **Costo**: Cloud Run cobra por CPU y memoria usada. Con 2Gi RAM y límites apropiados, es económico.

2. **Fuentes incluidas**: La imagen ya incluye todas las fuentes árabes del directorio `fonts/`.

3. **Timeout**: Configurado a 300 segundos (5 minutos) para procesar videos largos.

4. **Escalado**: Automático hasta 10 instancias máximo.

## 🔧 Troubleshooting

### Error de memoria:
```bash
gcloud run deploy ... --memory 4Gi
```

### Error de timeout:
```bash
gcloud run deploy ... --timeout 600
```

### Ver logs:
```bash
gcloud logs read --service nca-toolkit-arabic --region us-central1
```