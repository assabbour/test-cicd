# Étape 1 : Build de l'application Angular
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Étape 2 : Serveur NGINX pour déployer l'application
FROM nginx:latest
COPY dist/mon-projet-angular /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
RUN ls -la dist



