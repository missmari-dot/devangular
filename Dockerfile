# Étape 1 : Build de l'application Angular
FROM node:18 AS build

WORKDIR /usr/local/app

# Installer Angular CLI globalement
RUN npm install -g @angular/cli

COPY ./ /usr/local/app/
RUN npm install
RUN ng build --configuration production

# Étape 2 : Serveur Nginx
FROM nginx:alpine

# Copiez le contenu du dossier dist généré par Angular vers le dossier HTML de Nginx
COPY --from=build /usr/local/app/release/dist/crud-etudiant /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
