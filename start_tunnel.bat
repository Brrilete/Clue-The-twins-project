@echo off
timeout /t 15 /nobreak
cloudflared tunnel --url http://localhost:8000
