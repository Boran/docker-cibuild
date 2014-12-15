# docker SSH container for jenkins builds
# Ubuntu 14.04 +ssh
#
FROM             ubuntu:14.04
MAINTAINER       Sean Boran <sean_at_boran.com>
ENV REFRESHED_AT 2014-12-15

# Install Depends
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get -qqy update && \
    apt-get -qy install wget git curl git-core openssh-server && \
    mkdir -p /var/run/sshd

# Add user jenkins to the image
#RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
#RUN echo "jenkins:jenkins" | chpasswd

# Expose volumes
VOLUME /var/log

EXPOSE 22

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh 

CMD ["/bin/bash", "/start.sh"]


