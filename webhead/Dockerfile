FROM ubuntu:wily
MAINTAINER vlado@dikini.net
ENV \
  TERM=xterm \
  DRUPAL_DOCROOT=/var/www/html \
  DRUPAL_PROFILE=invotra_standard \
  DEBIAN_FRONTEND=noninteractive \
  ACCOUNT_NAME=admin \
  ACCOUNT_PASS=somepassword \
  SITE_NAME="glorious one" \
  MYSQL_ROOT_PASSWORD=somepassword \
  DB=webdb \
  APACHE_LOCK_DIR=/var/lock/apache2 \
  APACHE_PID_FILE=apache.pid \
  APACHE_RUN_USER=www-data \
  APACHE_RUN_GROUP=www-data \
  APACHE_LOG_DIR=/var/log/apache2 

WORKDIR /var/www/html
COPY run.sh /root/run.sh

RUN   apt-get -y update \
  &&  chmod -R u+w /root/run.sh \
  &&  apt-get install -y php5-cli apache2  libapache2-mod-php5 php5-gd php5-mysql php5-memcached php5-solr php5-intl composer  \
          git vim-tiny curl wget pwgen vim \
  &&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  &&  curl -s https://files.drush.org/drush.phar > /usr/local/bin/drush \
  &&  chmod a+x /usr/local/bin/drush 

COPY run.sh /root/run.sh
COPY build.sh /root/build.sh

CMD ["/root/run.sh","/bin/bash"]

