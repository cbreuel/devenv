from ubuntu:eoan

ENV DOCKER_USER cbreuel

# Create user
RUN apt-get update && \
    apt-get install -y sudo && \
    adduser --disabled-password --gecos '' "$DOCKER_USER" && \
    adduser "$DOCKER_USER" sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    touch /home/$DOCKER_USER/.sudo_as_admin_successful && \
    rm -rf /var/lib/apt/lists/*

USER "$DOCKER_USER"

WORKDIR "/home/$DOCKER_USER"

# Install basic development packages
RUN yes | sudo unminimize && \
	sudo apt-get update && \
    sudo apt-get install -y man-db bash-completion build-essential curl openssh-client && \
    sudo apt-get install -y git && \
    sudo apt-get install -y tmux && \
    sudo apt-get install -y vim && \
    sudo apt-get install -y python3 && \
    sudo apt-get install -y python3-pip && \
    sudo rm -rf /var/lib/apt/lists/*

# Install personal config options
RUN curl -L https://raw.githubusercontent.com/cbreuel/devenv/master/setup.sh | bash

