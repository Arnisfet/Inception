#Этапы запуска контейнера:
# 1) Создание образа docker build -t maria .
# 2) Обычный запуск образа:
# docker run -p 8000:3306 -d  --name mariadb maria

# Интерактивный формат запущенного контейнера :
# docker exec -it mariadb sh

# Подключение к mysql:
# mysql -u mrudge -p
FROM debian:buster

# Install the server
RUN apt update
RUN apt-get -y install mariadb-server

EXPOSE 3306

# копирует в контейнер файлы и папки
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

# описывает команду с аргументами, которую нужно выполнить когда контейнер будет запущен
CMD /usr/bin/mysqld_safe
