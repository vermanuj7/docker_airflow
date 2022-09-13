#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Specify the project name as argument eg. ./initialize.sh minimal_image"
  mkdir -p "$DOCKER_AIRFLOW_HOME/dags" "$DOCKER_AIRFLOW_HOME/logs" "$DOCKER_AIRFLOW_HOME/plugins" && \
  touch "$DOCKER_AIRFLOW_HOME/.env" && \
  echo -e "AIRFLOW_UID=$(id -u)" > "$DOCKER_AIRFLOW_HOME/.env"
else
  mkdir -p "$DOCKER_AIRFLOW_HOME/dags" "$DOCKER_AIRFLOW_HOME/logs" "$DOCKER_AIRFLOW_HOME/plugins" && \
  touch "$DOCKER_AIRFLOW_HOME/.env" && \
  echo -e "AIRFLOW_UID=$(id -u)" > "$DOCKER_AIRFLOW_HOME/.env"
fi
