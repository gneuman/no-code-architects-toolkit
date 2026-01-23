#!/bin/bash

# Script para hacer deploy de la versión con fuentes árabes a Google Cloud Run
# Ejecutar desde el directorio raíz del proyecto

echo "🚀 Construyendo imagen Docker con fuentes árabes..."
docker build -t nca-toolkit-arabic:latest .

echo "🏷️  Taggeando imagen para Google Container Registry..."
PROJECT_ID=$(gcloud config get-value project)
docker tag nca-toolkit-arabic:latest gcr.io/$PROJECT_ID/nca-toolkit-arabic:latest

echo "📤 Subiendo imagen a Google Container Registry..."
docker push gcr.io/$PROJECT_ID/nca-toolkit-arabic:latest

echo "☁️  Desplegando a Google Cloud Run..."
gcloud run deploy nca-toolkit-arabic \
  --image gcr.io/$PROJECT_ID/nca-toolkit-arabic:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars "API_KEY=tu_api_key_aqui" \
  --set-env-vars "GCP_SA_CREDENTIALS=tu_service_account_json" \
  --set-env-vars "GCP_BUCKET_NAME=tu_bucket_name" \
  --memory 2Gi \
  --cpu 1 \
  --max-instances 10 \
  --timeout 300

echo "✅ Deploy completado!"
echo "🌐 URL del servicio:"
gcloud run services describe nca-toolkit-arabic --region us-central1 --format "value(status.url)"