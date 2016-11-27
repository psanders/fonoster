FROM google/cloud-sdk:latest
MAINTAINER Pedro Sanders <fonosterteam@fonoster.com>

# Installing Java & Maven
RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get -y install openjdk-8-jdk \
    && apt-get -y install maven

# Ruby, Git, ETC
RUN  apt-get install -yq ruby ruby-dev build-essential git curl \
     && bash -c "curl -L https://www.opscode.com/chef/install.sh | bash" \
     && /opt/chef/embedded/bin/gem install --no-ri --no-rdoc berkshelf \
     && mkdir -p /opt/fn/scripts \
     mkdir /opt/fn/credentials

COPY kube/              /opt/fn/resources
COPY credentials/       /opt/fn/credentials
COPY scripts/           /opt/fn/scripts

RUN chmod +x /opt/fn/scripts/*

RUN wget https://github.com/fonoster/astivetoolkit/archive/v1.0.5.tar.gz \
    && tar xvf v1.0.5.tar.gz \
    && cd astivetoolkit-1.0.5 \
    && mvn install

ADD . /app
WORKDIR /app