FROM smirnovigor077/cv:latest

RUN rm  -rf /etc/nginx/conf.d/*

COPY lb.conf /etc/nginx/conf.d/

CMD ["nginx","-g","daemon off;"]
