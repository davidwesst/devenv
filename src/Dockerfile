FROM debian:bullseye
MAINTAINER David Wesst "https://github.com/davidwesst"

ENV SSH_PASSWORD {SSH_PASSWORD:-sshpassword}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y openssh-server \
						git \
						curl
RUN mkdir -p /var/run/sshd
RUN echo "root:$SSH_PASSWORD" | chpasswd
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Create workspace dir
RUN mkdir /root/workspace
WORKDIR /root/workspace

# Start script
COPY start.sh /root/start.sh

EXPOSE 22 80 443
CMD ["/root/start.sh"]
