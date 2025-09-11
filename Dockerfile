FROM  almalinux

RUN dnf install -y httpd
COPY index.html /var/www/html/index.html

EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]