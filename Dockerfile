# Gera o site Flutter Web e serve na porta 8084 (Caddy: liso.etoolstec.com.br).
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter pub get \
 && (test -f assets/images/logo.b64 && make logo || true) \
 && flutter build web --release --base-href /

FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 8084
CMD ["nginx", "-g", "daemon off;"]
