cat > ~/Desktop/iniciar-gemelos.sh << 'EOF'
#!/bin/bash
echo "Iniciando contenedores..."
cd ~/Desktop/GEMELOS
docker-compose up -d
echo "✅ Listo! Abre http://localhost:5173 para desarrollo"
echo "   o lanza ngrok para acceso externo"
EOF
chmod +x ~/Desktop/iniciar-gemelos.sh