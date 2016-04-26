FROM ubuntu:vivid
ENV LC_ALL C
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV SOLR_VERSION 5.4.1
ENV SOLR solr-$SOLR_VERSION

RUN export DEBIAN_FRONTEND=noninteractive \
&& echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu vivid main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
&& echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu vivid main" | tee -a /etc/apt/sources.list.d/webupd8team-jav.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get -y install lsof curl procps \
&& echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
&& apt-get -y install \
oracle-java7-installer \
oracle-java7-set-default \
&& update-alternatives --display java \
&& rm -rf /var/cache/oracle-jdk7-installer \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& mkdir -p /opt \
&& wget -nv --output-document=/opt/$SOLR.tgz http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/$SOLR_VERSION/$SOLR.tgz \
&& tar -C /opt --extract --file /opt/$SOLR.tgz \
&& rm /opt/$SOLR.tgz \
&& ln -s /opt/$SOLR /opt/solr \
&& mkdir /opt/solr/server/solr/drupal

COPY solr-conf/drupal /opt/solr/server/solr/

# Need to add unit files that do
CMD ["bash", "-c",  "/opt/solr/bin/solr -f"]
