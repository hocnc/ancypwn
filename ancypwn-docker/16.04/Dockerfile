FROM ubuntu:16.04

MAINTAINER Anciety <anciety512@gmail.com>

# Apt packages
RUN dpkg --add-architecture i386 && apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    git nasm  python \
    build-essential \
    python-dev python-pip python-setuptools \
    libc6-dbg \
    libc6-dbg:i386 \
    gcc-multilib \
    gdb-multiarch \
    gcc \
    wget \
    curl \
    glibc-source \
    cmake \
    python-capstone \
    socat \
    netcat \
    ruby \
    lxterminal && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd ~ && tar -xf /usr/src/glibc/glibc-2.23.tar.xz

# python/ruby packages & gdb-plugin
RUN pip install --no-cache-dir pwntools ropper ancypatch && \
    gem install one_gadget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# git installaing package
RUN cd ~/ && \
    git clone https://github.com/pwndbg/pwndbg.git && \
    cd ~/pwndbg/ && ./setup.sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG C.UTF-8

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
