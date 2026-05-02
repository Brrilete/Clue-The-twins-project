@echo off
echo Iniciando contenedores de GEMELOS...
cd /d %USERPROFILE%\Desktop\GEMELOS
docker-compose up -d
echo.
echo Listo! Contenedores corriendo.
echo Abre http://localhost:5173 para desarrollo
echo Para acceso externo lanza ngrok manualmente
pause