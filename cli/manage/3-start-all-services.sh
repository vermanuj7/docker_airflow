#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Specify the project name as argument eg -> ./start-all-services.sh minimal_image"
  docker-compose -f "$DOCKER_AIRFLOW_HOME/docker-compose.yaml" up -d
else
  docker-compose -f "$DOCKER_AIRFLOW_HOME/docker-compose.yaml" up -d
fi
