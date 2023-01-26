#!/bin/bash
function invalid {
  echo ""
  echo "Invalid command"
  echo ""
  echo "Create local postgres container:  prog-graph.sh [local]"
  echo "Install dependencies:             prog-graph.sh [install]"
  echo "Docker services:                  prog-graph.sh [build|start|stop|restart] [dev|prod]"
  echo "Docker status:                    prog-graph.sh [status]"
  echo ""
}
function status () {
  docker container ls --all
}
function localPostgresDocker () {
  docker run --name postgres-db -e POSTGRES_PASSWORD=pw_postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=prog_graph -p 5432:5432 -d postgres:latest
  docker stop postgres-db
}
function installDependencies () {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo curl -fsSL https://get.docker.com | sudo sh
  sudo apt autoremove -y
  sudo docker pull postgres
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo reboot
}
function exec {
  if [ $1 = build ]
  then
    docker build --file docker/docker_app --tag prog-graph_app-$2 --build-arg SYSTEM_ENV=$2 .
    docker compose --file docker/docker-compose_$2.yml --project-name prog-graph_$2 create
  else
    docker compose --file docker/docker-compose_$2.yml --project-name prog-graph_$2 $1
  fi
  docker container ls --all
}
case $1 in
status)status;;
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
restart)
  case $2 in
    dev)exec restart dev;;
    prod)exec restart prod;;
    *)invalid;;
  esac;;
*)invalid;;
esac