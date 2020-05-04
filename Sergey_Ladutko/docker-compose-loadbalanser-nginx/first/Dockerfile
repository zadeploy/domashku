FROM nginx:alpine
COPY index.html /usr/share/nginx/html
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:80 || exit 1