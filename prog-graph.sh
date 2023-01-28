#!/bin/bash
function help {
  echo ""
  echo "Help:                             prog-graph.sh [help]"
  echo "Setup for use on linux:           prog-graph.sh [setup]"
  echo "Create postgres dev db:           prog-graph.sh [dev] [db]"
  echo "Docker build:                     prog-graph.sh [build] [test|int|prod]"
  echo "Docker start:                     prog-graph.sh [start] [test|int|prod]"
  echo "Docker stop:                      prog-graph.sh [stop] [test|int|prod]"
  echo "Docker restart:                   prog-graph.sh [restart] [test|int|prod]"
  echo "Docker stop-build-start:          prog-graph.sh [rebuild] [test|int|prod]"
  echo "Docker logs:                      prog-graph.sh [logs] [test|int|prod]"
  echo "Docker status:                    prog-graph.sh [status]"
  echo ""
}
function invalid {
  echo ""
  echo "Invalid command"
  help
}
function setup {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo curl -fsSL https://get.docker.com | sudo sh
  sudo apt autoremove -y
  sudo docker pull postgres
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo reboot
}
function dev {
  docker run --name db-dev -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=prog-graph -p 5432:5432 -d postgres:latest postgres -c log_statement=all
  docker stop db-dev
}
function build {
  docker build --file docker/docker_app --tag prog-graph_app-$1 --build-arg SYSTEM_ENV=$1 .
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 create
  status
}
function start {
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 start
  status
}
function stop {
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 stop
  status
}
function restart {
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 restart
  status
}
function rebuild {
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 stop
  docker build --file docker/docker_app --tag prog-graph_app-$1 --build-arg SYSTEM_ENV=$1 .
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 create
  docker compose --file docker/docker-compose_$1.yml --project-name prog-graph_$1 start
  status
}
function logs {
  docker logs -f app-$1 2>&1 | sed -e 's/^/ [-- APP --] /' &
  docker logs -f db-$1 2>&1 | sed -e 's/^/ [-- DB --] /' &
}
function status {
  docker container ls --all
}
case $1 in
  help)help;;
  setup)setup;;
  dev)
    case $2 in
      db)dev;;
      *)invalid;;
    esac;;
  build)
    case $2 in
      test)build test;;
      int)build int;;
      prod)build prod;;
      *)invalid;;
    esac;;
  start)
    case $2 in
      test)start test;;
      int)start int;;
      prod)start prod;;
      *)invalid;;
    esac;;
  stop)
    case $2 in
      test)stop test;;
      int)stop int;;
      prod)stop prod;;
      *)invalid;;
    esac;;
  restart)
    case $2 in
      test)restart test;;
      int)restart int;;
      prod)restart prod;;
      *)invalid;;
    esac;;
  rebuild)
    case $2 in
      test)rebuild test;;
      int)rebuild int;;
      prod)rebuild prod;;
      *)invalid;;
    esac;;
  logs)
    case $2 in
      test)logs test;;
      int)logs int;;
      prod)logs prod;;
      *)invalid;;
    esac;;
  status)status;;
  *)invalid;;
esac