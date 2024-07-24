# Docker-case
Neste projeto utilizo a ferramenta Docker para criar um cluster containerizado SPARK.

Crio uma imagem personalizada no DockerFile com as configuracoes especificas para meu projeto utilizando python:3.11-bullseye. Nele instalo dependencias necessarias e configuro o ambiente spark para a imagem ser replicada em seus containers: Master, Worker e History. 

Arquivos necessarios para rodar o Dockerfile:
 - requirements.txt
 - spark-default.conf 
 - entrypoint.sh  

## Docker-compose

Aqui é configurado portas, volumes, imagem e o poder computacional de cada container: Master, worker, history. 

## Configuracoes adicionais

Utilizo outros containers para desenvolver meus codigos, projetos e rodar processos mas se seu poder compuntacional for mais limitado é possível utilizar a propria master. 

### Configuracao SSH na Master

Para configuracoes SSH somente na master foi necessario adicionar linhas de comando no entrypoint.sh, onde existe uma condicao que aponta somente para o conteiner master. 

O ssh no conteiner Docker tem suas peculiaridades, sendo necessario configuracao nas pastas **/etc/ssh/sshd_config, /etc/pam.d/sshd e /etc/profile**

Gerei uma chave publica ssh para a conexao host e container, havendo mais seguranca na minha conexao, criei uma pasta /ssh/authorized_key que possui o valor da chave, é exigido tambem configuracao de permissionamento rwx.

chmod 600: O proprietário do arquivo tem permissão total para ler e escrever no arquivo (rw-) e nenhum acesso é permitido para grupos de usuários ou para outros (---).
chmod700: O proprietário do arquivo tem permissão total para ler, escrever e executar o arquivo (rwx) e nenhum acesso é permitido para grupos de usuários ou para outros (---).

## Rede Personalizada 

Foi criado uma rede personalizada para simular um ambiente aberto a conexoes externas e nao somente local, tendo ip fixo para conexoes ssh atraves do ip e nao somente LocalHost. 

################################################################################################################################################################################

Com esse Docker-compose fica mais facil configurar um cluster spark para diversos projetos. Se você possui um ambiente de containers robusto, existe a possibilidade de orquestra-los atraves do **Kubernets**. Tambem podendo ter um container que utiliza o **apache airflow** para orquestrar o cluster e outros processos. 
























