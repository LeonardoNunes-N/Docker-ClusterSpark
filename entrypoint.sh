#!/bin/bash

SPARK_WORKLOAD=$1 

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then 
  export $(cat /root/.ssh/environment | xargs) &
  # Inicializacao repositorio git 
  cd $CASEDIR
  git init 
  git config --global user.name "${GIT_USER_NAME}" 
  git config --global user.email "${GIT_USER_EMAIL}" 
  # Instalação do OpenSSH Server
  apt-get update
  apt-get install -y openssh-server
  mkdir /var/run/sshd
  echo 'root:root' | chpasswd
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  sed -i 's/#PermitUserEnvironment no/#PermitUserEnvironment yes/' /etc/ssh/sshd_config
  # SSH login fix. Otherwise user is kicked off after login
  sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
  echo "export VISIBLE=now" >> /etc/profile
  apt-get clean
  rm -rf /var/lib/apt/lists/* 

  mkdir -p /root/.ssh
  chmod 600 /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/environment
  chmod 700 /root/.ssh

  # Configurar o SSH
  echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
  echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config

  service ssh start

  cd
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