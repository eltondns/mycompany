from jenkins/jenkins:2.60.1

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes

# Update aptitude with new repo
RUN apt-get update

# Install software 
RUN apt-get install -y git

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN jx import --url https://github.com/eltondns/mycompany.git

# install Maven
USER root
RUN apt-get update && apt-get install -y maven
USER jenkins
