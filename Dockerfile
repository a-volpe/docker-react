FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
# We do not reference the folders since the app in production does not change
COPY . .
# The files that will be built will be in /app/build
RUN npm run build

# Everything above is dumped
FROM nginx
# does nothing in development - to understand which port to expose in elasticbeanstalk
EXPOSE 80
# The folder in which to put stuff for a static web content is this one
COPY --from=0 /app/build /usr/share/nginx/html
# The default commend for nginx starts the service, so no need to specify RUN