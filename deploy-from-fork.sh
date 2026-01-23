#!/bin/bash

# Script para hacer deploy directamente desde tu fork
# Usa tu repositorio personal en lugar del original

echo "🐳 Construyendo imagen desde tu fork..."

# Build desde el código local (tu fork)
docker build -t nca-arabic-fork:latest .

echo "🏷️  Taggeando imagen para GCR..."
PROJECT_ID=$(gcloud config get-value project 2>/dev/null || echo "tu-project-id")

if [ "$PROJECT_ID" = "tu-project-id" ]; then
    echo "❌ No tienes configurado un proyecto de GCP"
    echo "Ejecuta: gcloud config set project TU_PROJECT_ID"
    exit 1
fi

docker tag nca-arabic-fork:latest gcr.io/$PROJECT_ID/nca-arabic-fork:latest

echo "📤 Subiendo imagen..."
docker push gcr.io/$PROJECT_ID/nca-arabic-fork:latest

echo "☁️  Desplegando a Cloud Run..."
gcloud run deploy nca-arabic-fork \
  --image gcr.io/$PROJECT_ID/nca-arabic-fork:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars "API_KEY=tu_api_key_secreta" \
  --set-env-vars "GCP_SA_CREDENTIALS=tu_service_account_json" \
  --set-env-vars "GCP_BUCKET_NAME=tu_bucket" \
  --memory 2Gi \
  --cpu 1 \
  --max-instances 10 \
  --timeout 300

echo "✅ ¡Deploy completado desde tu fork!"
echo "🌐 URL del servicio:"
gcloud run services describe nca-arabic-fork --region us-central1 --format "value(status.url)" --quiet 2>/dev/null || echo "Ejecuta manualmente: gcloud run services describe nca-arabic-fork --region us-central1 --format 'value(status.url)'"