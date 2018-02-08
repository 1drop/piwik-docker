FROM webdevops/php-apache:debian-9

ENV PIWIK_VERSION 3.3.0
ENV php.geoip.custom_directory /var/www/html/misc

RUN apt-install php-geoip

RUN curl -fsSL -o piwik.tar.gz \
      "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz" \
 && rm -rf /app \
 && tar -xzf piwik.tar.gz -C /usr/src/ \
 && mv /usr/src/piwik /app \
 && rm piwik.tar.gz

RUN curl -fsSL -o /app/misc/GeoIPCity.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
 && gunzip /app/misc/GeoIPCity.dat.gz \
 && chown "$APPLICATION_USER":"$APPLICATION_GROUP" /app/misc/GeoIPCity.dat
