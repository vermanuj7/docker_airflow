#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Specify the project name as argument eg -> ./initialize-database.sh minimal_image"
  docker-compose -f "$DOCKER_AIRFLOW_HOME/docker-compose.yaml" up airflow-init -d
else
  docker-compose -f "$DOCKER_AIRFLOW_HOME/docker-compose.yaml" up airflow-init -d
fi
