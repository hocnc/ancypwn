FROM ubuntu:14.04

MAINTAINER Anciety <anciety512@gmail.com>

# Apt packages (without libc source code)
RUN dpkg --add-architecture i386 && \
   sed 's/# deb-src/deb-src/g' /etc/apt/sources.list > /tmp/source && \
    mv /tmp/source /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    openssh-server \
    git nasm  python \
    build-essential \
    python-dev python-pip python-setuptools \
    xz-utils \
    libc6-dbg \
    libc6-dbg:i386 \
    gcc-multilib \
    gdb-multiarch \
    gcc \
    wget \
    curl \
    cmake \
    socat \
    netcat \
    ruby \
    libffi-dev \
    openssl \
    libssl-dev \
    lxterminal && \
    cd ~/ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# python/ruby packages & gdb-plugin
RUN pip install --upgrade pip setuptools && pip install pwntools ropper ancypatch capstone && \
    gem install one_gadget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# git installaing package
RUN cd ~/ && \
    git clone https://github.com/pwndbg/pwndbg.git && \
    cd ~/pwndbg/ && ./setup.sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENV LANG C.UTF-8

CMD ["/usr/sbin/sshd", "-D"]
