# docker SSH container for jenkins builds
# 
# based on boran/drupal, since it will be used to build websites
#
FROM             boran/drupal
MAINTAINER       Sean Boran <sean_at_boran.com>
ENV REFRESHED_AT 2014-12-15

# Drupal start.sh: install dependancies, but not drupal
ENV DRUPAL_NONE skip

# Use a proxy for downloads?
#ENV PROXY http://proxy.example.ch:80

# Install  software: git, mysql, php, apache
# lamp is needed for building test websites
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get -qqy update && \
    apt-get -qy install openssh-server && \
    mkdir -p /var/run/sshd


# Add user jenkins
RUN useradd -m -U -d /home/builder -c 'Automated CI user' --shell /bin/bash jenkins
# Set password for the jenkins user 
#RUN echo "jenkins:jenkins" | chpasswd


# Install built/test software
RUN apt-get -qy install python-mysqldb python-setuptools python-dev libgmp-dev phantomjs php5-cli atool vim
# todo: pip is inefficent, runs every time, packages would be better
# python-pycryptopp ?
RUN easy_install pip
RUN pip install --quiet -I pycrypto
RUN pip install --quiet paramiko PyYAML jinja2 httplib2 markupsafe
RUN pip install --quiet ansible

# http://codeception.com/install
RUN mkdir /opt/codecept
ADD http://codeception.com/codecept.phar /opt/codecept/codecept.phar
RUN chmod 755 /opt/codecept/codecept.phar
RUN ln -s /opt/codecept/codecept.phar /usr/bin/codecept
WORKDIR /opt/codecept
RUN php codecept.phar bootstrap

ADD ./files/ansible/hosts /etc/ansible/hosts
ADD ./files/etc/vim/vimrc /etc/vim/vimrc

# allow jenkins user sudo on build script
ADD ./files/etc/sudoers.d/jenkins /etc/sudoers.d/jenkins

# SSH startup
ADD ./files/supervisord.d    /etc/supervisord.d

# Expose volumes
VOLUME /home/builder
VOLUME /var/log

WORKDIR /home/builder
EXPOSE 22 80 

## dont override start.sh, use the one in boran/drupal
#ADD ./start.sh /start.sh
#RUN chmod 755 /start.sh 
#CMD ["/bin/bash", "/start.sh"]

ADD ./custom.sh /custom.sh
RUN chmod 755 /custom.sh

