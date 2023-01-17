FROM debian:bullseye
MAINTAINER David Wesst "https://github.com/davidwesst"

ENV SSH_PASSWORD {SSH_PASSWORD:-sshpassword}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y openssh-server \
						git \
						curl \
						vim \
						make \
						fontconfig
# setup ssh
RUN mkdir -p /var/run/sshd
RUN echo "root:$SSH_PASSWORD" | chpasswd
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Locale
RUN apt-get install -y locales
RUN locale-gen en_CA.utf8
ENV LANG en_CA.utf8
ENV LANGUAGE en_CA:en
ENV LC_ALL en_CA.utf8
RUN update-locale LANG=en_CA.utf8 

# install dotfiles
RUN git clone https://github.com/davidwesst/dotfiles /root/dotfiles/
RUN make --file /root/dotfiles/Makefile -C /root/dotfiles/

# Create workspace dir
RUN mkdir /root/workspace
WORKDIR /root/workspace

# Start script
COPY start.sh /root/start.sh

EXPOSE 22 80 443
CMD ["/root/start.sh"]
