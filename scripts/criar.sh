#!/bin/bash

docker network create dimdim-network

docker volume create mysql-dimdim-volume

docker run --name mysql-dimdim-RM562259 -d \
--network dimdim-network \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=root-dimdim \
-e MYSQL_DATABASE=db_dimdim \
-e MYSQL_USER=user_dimdim \
-e MYSQL_PASSWORD=senha_dimdim \
-v mysql-dimdim-volume:/var/lib/mysql \
mysql:8.0

cd api-dimdim

docker run --name api-dimdim-RM562259 -d \
-v $(pwd):/app \
-w /app \
-p 8080:8080 \
--network dimdim-network \
maven:3.9-eclipse-temurin-17 \
mvn spring-boot:run
