# Clue-The-twins-project
Para iniciar el proyecto:


Iniciar Docker

Terminal 1:
    ./ngrok http 8001

Terminal 2:
    cd ~/Desktop/GEMELOS
    docker-compose up -d

WEB:
    https://petroleum-blah-dinner.ngrok-free.dev/



Cada vez que haga un cambio 
Para que se vea reflejado en los diferentes dispositivos:

    ~/Desktop/GEMELOS/deploy-frontend.sh

    cd ~/Desktop/GEMELOS/frontend
    npm run build
    cp -r dist/* ../rpg-game/public/


Comandos de interés:
    Resetear progreso de un juegador: 
            docker exec -it gemelos-laravel-1 php artisan player:reset 2


















            
Antiguamente....
Terminal 1 (Docker) $ docker-compose up -d
            Aqui lanzamos:
                La BBDD (http://localhost:8080)
                La IA
                la API

Terminal 2 (Frontend) npm run dev   
                    http://localhost:5173/

