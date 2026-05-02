@echo off
echo 🔨 Compilando frontend...

cd /d %USERPROFILE%\Desktop\GEMELOS\frontend

npm run build

echo 📦 Copiando a Laravel...
xcopy dist ..\rpg-game\public /E /I /Y

echo ✅ Listo!
pause