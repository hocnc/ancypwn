FROM ubuntu:18.04

MAINTAINER Anciety <anciety512@gmail.com>

# Apt packages
RUN apt-get update && \
    apt-get install -qy \
    openssh-server  \
    git nasm python \
    build-essential \
    python-dev python-pip python-setuptools \
    libc6-dbg \
    gcc-multilib \
    gdb-multiarch \
    gcc \
    wget \
    glibc-source \
    cmake \
    python-capstone \
    ruby && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \ 
    cd ~ && tar -xvf /usr/src/glibc/glibc-*.tar.xz


# git installaing package
RUN cd ~/ && \
    git clone https://github.com/pwndbg/pwndbg.git && \
    cd ~/pwndbg/ && ./setup.sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# python/ruby packages & gdb-plugin
RUN pip install pwntools && \
    gem install one_gadget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENV LANG C.UTF-8

CMD ["/usr/sbin/sshd", "-D"]
