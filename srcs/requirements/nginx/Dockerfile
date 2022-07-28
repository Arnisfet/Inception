FROM debian

RUN apt update
RUN apt install -y nginx openssl

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/start.sh /var/www
COPY index.html /var/www/index.html

CMD bash var/www/start.sh 
