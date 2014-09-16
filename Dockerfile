FROM debian:latest

MAINTAINER Athanasios Douitsis <aduitsis@cpan.org>

RUN apt-get update && apt-get install -y supervisor vim curl apache2 php5 php-pear php5-mysql libapache2-mod-shib2 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod shib2

ADD apache-default-site /etc/apache2/sites-available/default

ADD ntuasigner.pem /etc/shibboleth/ntuasigner.pem

ADD shibboleth2.xml /etc/shibboleth/shibboleth2.xml

ADD start-services.sh /root/start-services.sh

RUN chmod u+x /root/start-services.sh

RUN shib-keygen

RUN mkdir /var/www/secure && echo '<?php phpinfo(); ?>' > /var/www/secure/index.php

ADD attribute-map.xml /etc/shibboleth/attribute-map.xml

### CMD ["/root/start-services.sh"]

EXPOSE 80 443
