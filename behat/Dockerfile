FROM php:5.5-cli
MAINTAINER Vladimir Zlatanov

# Update and install packages
RUN apt-get update
RUN apt-get install -y curl git vim

RUN apt-get update && apt-get install -y php5-curl libpng12-dev libjpeg-dev libpq-dev mariadb-client bzip2 libbz2-dev\
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql bz2

# Create "behat" user with password crypted "behat"
RUN useradd -d /home/behat -m -s /bin/bash behat
RUN echo "behat:behat" | chpasswd


## Fix permissions
#RUN chown -R behat:behat /home/behat

# Add "behat" to "sudoers"
RUN echo "behat        ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER behat
WORKDIR /home/behat
ENV HOME /home/behat
ENV PATH $PATH:/home/behat:/home/behat/composer/bin


# Install Behat
RUN mkdir composer \
 && mkdir xml

#COPY automated-tests /home/behat/
COPY composer.json composer/composer.json

RUN cd /home/behat/composer && curl http://getcomposer.org/installer | php
RUN cd /home/behat/composer && php composer.phar install --prefer-source

# Behat alias in docker container
#ADD behat /home/behat/behat
#RUN chmod +x /home/behat/behat

#Clone automated tests
#RUN git clone https://github.com/invotra/automated-tests.git

#copy the runner script into container
#COPY run.sh /home/behat/run.sh

# The behat runner
CMD ["/bin/bash", "-c",  "behat --tags "@acceptance" --format "junit, progress" --out xml,"]