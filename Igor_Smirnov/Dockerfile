FROM ubuntu

RUN apt-get update

RUN apt-get install nginx -y

RUN apt-get install apache2-utils -y

RUN apt-get install openssl -y

ARG admin_username=admin

ARG admin_password

RUN htpasswd -cb /etc/nginx/.htpasswd $admin_username $admin_password

COPY generate-ssl.sh /

RUN chmod +x /generate-ssl.sh && /generate-ssl.sh

COPY cv /var/www/smirnovcv.com

COPY admin /var/www/admin.smirnovcv.com

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

EXPOSE 443

CMD ["nginx","-g","daemon off;"]
