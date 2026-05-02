#!/bin/bash
echo "🔨 Compilando frontend..."
cd ~/Desktop/GEMELOS/frontend
npm run build

echo "📦 Copiando a Laravel..."
cp -r dist/* ../rpg-game/public/

echo "✅ Listo!"