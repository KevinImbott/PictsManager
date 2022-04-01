FROM centos:centos7
RUN yum install httpd -y
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN chown -R apache:apache /var/www/html/
CMD "rm /var/www/html/index.html"

COPY ./PICTS/ /var/www/html/
COPY ./httpd.conf  /etc/httpd/conf.d/httpd.conf

EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]