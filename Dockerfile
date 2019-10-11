FROM node:6 as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install -g @angular/cli@">=1.5.6 <2.0.0" node-sass && npm install
COPY . /app
RUN ng build --env=prod --output-path=dist --base-href /sawtooth-explorer --deploy-url /sawtooth-explorer
FROM nginx:1.16.0-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 4201
CMD ["nginx", "-g", "daemon off;"]
