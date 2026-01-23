#!/bin/bash

# Script para verificar qué cambios hay disponibles en upstream
# NO modifica tu código, solo informa

echo "🔍 Verificando actualizaciones del repositorio upstream..."
echo ""

# Asegurarse de tener el upstream configurado
git remote add upstream https://github.com/stephengpope/no-code-architects-toolkit.git 2>/dev/null || echo "Upstream ya configurado"

# Fetch de todos los cambios
git fetch upstream

echo "📊 Estado actual:"
echo "Tu branch: $(git branch --show-current)"
echo "Tu último commit: $(git log -1 --oneline)"
echo "Upstream main: $(git log upstream/main -1 --oneline)"
echo ""

# Ver si hay cambios disponibles
BEHIND=$(git rev-list HEAD..upstream/main --count)
AHEAD=$(git rev-list upstream/main..HEAD --count)

if [ $BEHIND -gt 0 ]; then
    echo "⬇️  Tienes $BEHIND commits atrasados del upstream"
    echo ""
    echo "📋 Cambios disponibles:"
    git log --oneline HEAD..upstream/main
else
    echo "✅ Estás al día con upstream"
fi

if [ $AHEAD -gt 0 ]; then
    echo ""
    echo "⬆️  Tienes $AHEAD commits adelante del upstream (tus cambios)"
fi