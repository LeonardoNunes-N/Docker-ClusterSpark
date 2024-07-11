# Docker-case
Neste projeto utilizo a ferramenta Docker para criar um ambiente containerizado SPARK e Postgresql 

Crio uma imagem personalizada no DockerFile com as configuracoes especificas para meu projeto utilizando python:3.11-bullseye. Nele instalo dependencias necessarias e configuro o ambiente spark para a imagem ser replicada em seus containers: Master, Worker e History. 

Arquivos necessarios para rodar o Dockerfile é requirements.txt, spark-default.conf e entrypoint.sh 

*Configuracao SSH 
Para configuracoes SSH somente na master foi necessario adicionar linhas de comando no entrypoint.sh, onde existe uma condicao que aponta somente para o conteiner master. 

O ssh no conteiner tem suas peculiaridades, sendo necessario configuracao nas pastas /etc/ssh/sshd_config, /etc/pam.d/sshd e /etc/profile

Gerei uma chave publica ssh para a conexao host e container, havendo mais seguranca na minha conexao, criei uma pasta /ssh/authorized_key que possui o valor da chave, é exigido tambem configuracao de permissionamento rwx.

chmod 600: O proprietário do arquivo tem permissão total para ler e escrever no arquivo (rw-) e nenhum acesso é permitido para grupos de usuários ou para outros (---).
chmod700: O proprietário do arquivo tem permissão total para ler, escrever e executar o arquivo (rwx) e nenhum acesso é permitido para grupos de usuários ou para outros (---).

*Docker-compose

Aqui é configurado portas, volumes, imagem, poder computacional de cada container: master, worker, history e database. 

O database utiliza a imagem do 'postgres:latest', para a percistencia de dados é utilizado uma pasta entre o host e o container configurado no volume. Dois arquivos sao utilizados para o container do database, .env para as credencias do banco de dados e init.sql para ser o script que sera rodado no banco assim que iniciar o container.

*Rede Personalizada 

Foi criado uma rede personalizada para simular um ambiente aberto a conexoes externas e nao somente local, tendo ip fixo para conexoes ssh atraves do ip e nao somente LocalHost. 

################################################################################################################################################################################

Esse projeto é a primeira parte do Case, com o intuito de estruturar o ambiente para o ETL. A segunda parte esta no Repositorio Spark-case.
























