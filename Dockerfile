# Etapa 1: compilar la aplicación Ionic
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Etapa 2: publicar los archivos web
FROM nginx:alpine
COPY --from=build /app/www /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]