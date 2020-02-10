#BUILD PHASE
FROM node:alpine AS builder

WORKDIR /usr/app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# RUN PHASE

FROM nginx

# Elastic Beanstalk uses this line to map hosting to the port exposed in this dockerfile
EXPOSE 80

COPY --from=builder /usr/app/build /usr/share/nginx/html
