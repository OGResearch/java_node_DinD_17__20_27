FROM node:20.12.2
RUN \
  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install openjdk-17-jdk-headless \
  && npm install -g npm@latest

# Instalar Docker no contêiner
RUN apt-get -y install docker.io

# # Configurar o usuário do Docker
# RUN groupmod -G docker ${USER}

# # Permitir que o usuário execute comandos Docker sem sudo
# RUN echo "${USER}:$(id -g docker)" | tee -a /etc/group

RUN \
  cat /var/run/docker.sock \
  ll /var/run/ \
  groups \
  ls -l /lib/systemd/system/docker.socket
RUN \
  sudo groupadd docker \
  sudo usermod -aG docker $USER \
  newgrp docker
RUN \
  sudo chmod 666 /var/run/docker.sock \
  sudo chgrp docker /lib/systemd/system/docker.socket \
  sudo chmod g+w /lib/systemd/system/docker.socket