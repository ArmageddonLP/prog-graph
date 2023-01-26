#!/bin/bash
function invalid {
  echo ""
  echo "Invalid command"
  echo ""
  echo "Create local postgres container:  prog_graph.sh [local]"
  echo "Install dependencies:             prog_graph.sh [install]"
  echo "Docker services:                  prog_graph.sh [build|start|stop] [dev|prod]"
}
function localPostgresDocker () {
  docker run --name postgres-db -e POSTGRES_PASSWORD=pw_postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=prog_graph -p 5432:5432 -d postgres:latest
  docker stop postgres-db
}
function installDependencies () {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install docker -y
  sudo apt autoremove -y
  sudo docker pull postgres
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo shutdown -r now
}
function exec {
  if [ $1 = build ]
  then
    docker build --file docker/docker_app --tag prog-graph_app-$2 --build-arg SYSTEM_ENV=$2 .
    docker compose --file docker/docker-compose_$2.yml --project-name prog-graph_$2 create
  else
    docker compose --file docker/docker-compose_$2.yml --project-name prog-graph_$2 $1
  fi
}
case $1 in
local)localPostgresDocker;;
install)installDependencies;;
build)
  case $2 in
    dev)exec build dev;;
    prod)exec build prod;;
    *)invalid;;
  esac;;
start)
  case $2 in
    dev)exec start dev;;
    prod)exec start prod;;
    *)invalid;;
  esac;;
stop)
  case $2 in
    dev)exec stop dev;;
    prod)exec stop prod;;
    *)invalid;;
  esac;;
*)invalid;;
esac