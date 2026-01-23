#!/bin/bash

# Script para sincronizar cambios del repositorio upstream (stephengpope)
# Ejecutar cuando quieras actualizar tu fork con cambios del original

echo "🔄 Actualizando desde upstream (stephengpope/no-code-architects-toolkit)..."

# Asegurarse de tener el upstream configurado
git remote add upstream https://github.com/stephengpope/no-code-architects-toolkit.git 2>/dev/null || echo "Upstream ya configurado"

# Fetch de todos los cambios
git fetch upstream

echo "📋 Cambios disponibles:"
git log --oneline upstream/main..origin/main

echo ""
echo "⚠️  ATENCIÓN: Esto mergeará cambios del upstream a tu branch actual"
read -p "¿Quieres continuar con el merge? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Crear backup branch antes del merge
    BACKUP_BRANCH="backup-$(date +%Y%m%d-%H%M%S)"
    git checkout -b $BACKUP_BRANCH
    git checkout -

    echo "🔀 Mergeando cambios del upstream..."
    git merge upstream/main --no-ff -m "Merge upstream changes from stephengpope/main"

    if [ $? -eq 0 ]; then
        echo "✅ Merge exitoso!"
        echo "💾 Backup creado en branch: $BACKUP_BRANCH"
        echo "🧪 Prueba tu aplicación antes de hacer push"
    else
        echo "❌ Hubo conflictos. Resuélvelos y luego:"
        echo "   git add <archivos_resueltos>"
        echo "   git commit"
    fi
else
    echo "❌ Merge cancelado"
fi