@echo off
timeout /t 15 /nobreak
cloudflared tunnel --url http://localhost:8000 2>&1 | findstr /i "trycloudflare.com" | findstr /i "https" >> C:\Users\jsf03\Desktop\mi_url_ia.txt
cloudflared tunnel --url http://localhost:8000
