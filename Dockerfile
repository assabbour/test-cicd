# Étape 1 : Builder l'application Angular
FROM node:18 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Étape 2 : Utiliser NGINX pour servir l'application Angular
FROM nginx:alpine AS production-stage
COPY --from=build-stage /app/dist/my-angular-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
