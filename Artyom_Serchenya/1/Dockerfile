FROM nginx
COPY ./files /usr/share/nginx/html
COPY --from=lachlanevenson/k8s-kubectl:v1.10.3 /usr/local/bin/kubectl /usr/local/bin/kubectl