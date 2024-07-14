#!/bin/bash

SPARK_WORKLOAD=$1 

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then 
  # Inicializacao repositorio git 
  cd $CASEDIR
  git init 
  git config --global user.name "${GIT_USER_NAME}" 
  git config --global user.email "${GIT_USER_EMAIL}" 
  cd

  #Transferencia envs POSTGRESQL para todos usuarios
  echo "export POSTGRES_USER='${POSTGRES_USER}'" >> /etc/profile
  echo "export POSTGRES_PASSWORD='${POSTGRES_PASSWORD}'" >> /etc/profile
  echo "export POSTGRES_DB='${POSTGRES_DB}'" >> /etc/profile
  echo "export VISIBLE=now" >> /etc/profile

  service ssh start

  # Inicia o nó mestre do Spark
  start-master.sh -p 7077 


elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh
fi

echo "Configuracao da $SPARK_WORKLOAD finalizada"