FROM webdevops/php-apache:debian-9

ENV PIWIK_VERSION 3.2.1
ENV php.geoip.custom_directory /var/www/html/misc

RUN apt-install php-geoip

RUN curl -fsSL -o piwik.tar.gz \
      "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz" \
 && rm -rf /var/www/html/ \
 && tar -xzf piwik.tar.gz -C /usr/src/ \
 && mv /usr/src/piwik /var/www/html \
 && rm piwik.tar.gz

RUN curl -fsSL -o /var/www/html/misc/GeoIPCity.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
 && gunzip /var/www/html/misc/GeoIPCity.dat.gz \
 && chown "$APPLICATION_USER":"$APPLICATION_GROUP" /var/www/html/misc/GeoIPCity.dat

 WORKDIR /var/www/html