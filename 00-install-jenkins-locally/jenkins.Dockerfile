FROM jenkins/jenkins:lts

USER root

RUN apt-get update
RUN apt-get install -y python3-pip lsb-release
RUN pip install --upgrade pip
RUN pip install --upgrade zapcli

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
