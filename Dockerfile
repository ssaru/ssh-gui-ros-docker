FROM ubuntu:16.04
MAINTAINER Martin, HWANG <dhhwang89@gmail.com>

# install basic environment
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
RUN apt-get autoremove

# change mirrors in ubuntu server: us to korea
RUN sed -i 's/security.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
RUN sed -i 's/us.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list

# install pre-required
RUN apt-get -y update && \
        apt-get install -y \
                sudo \
                vim \
                sudo \
                curl \
                wget \
                apt \
                base-files \
                libapt-pkg5.0 \
                libc-bin \
                libkmod2 \
                libudev1 \
                multiarch-support \
                systemd-sysv \
                lsb-release \
                command-not-found \
                python \
                python-pip \
                python3 \
                python3-pip \
                openssh-server \
		baobab \
		firefox \
                && rm -rf /var/lib/apt/lists/*

# set up your account password here
ARG user
ARG uid
ARG gid
ARG passwd
ARG display

# Add new user with our credentials
ENV USERNAME ${user}

# Add sudoer s & check /etc/sudoers file
RUN echo "$USERNAME     ALL=NOPASSWD:       ALL" >> /etc/sudoers
RUN cat /etc/sudoers

# Add new user with our credentials
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$passwd" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod --uid ${uid} $USERNAME && \
        groupmod --gid ${gid} $USERNAME

# set up root passwd
RUN echo "root:$passwd" | chpasswd

# set up default user & home directory
USER ${user}
WORKDIR /home/${user}

# print build parameter
RUN echo "user: $user"
RUN echo "uid : $uid"
RUN echo "gid : $gid"
RUN echo "USERNAME : $USERNAME"
RUN echo "passwd : $passwd"

# ssh setting
RUN mkdir /home/${user}/.ssh
RUN sudo mkdir /var/run/sshd

# open port
EXPOSE 22

# Install ROS
RUN wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_kinetic.sh && sudo chmod 755 ./install_ros_kinetic.sh && bash ./install_ros_kinetic.sh

RUN rosdep update

# X11 Forward setting
RUN sudo sed -i 's/#   ForwardX11 no/    ForwardX11 yes/g' /etc/ssh/ssh_config
RUN sudo cat /etc/ssh/ssh_config

# DISPLAY option setting
ENV DISPLAY ${display}
RUN echo "export DISPLAY=unix${display}" >> ~/.bashrc
RUN echo "display parameter : ${display}"

# start ssh
CMD ["sudo", "/usr/sbin/sshd", "-D"]
