#/bin/bash
docker-compose up --build -d
docker-compose exec api rails db:create
docker-compose exec api rails db:migrate