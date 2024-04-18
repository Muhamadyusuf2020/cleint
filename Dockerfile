#node image from dockerhub 
FROM node:18.20.0-alpine3.19 as node


# Create a directory where our app will be placed
RUN mkdir -p /usr/scr/app

WORKDIR /usr/src/app

COPY  *.json ./

RUN npm install 

COPY . . 
#build the application
RUN npm run build 
#stage 2 
FROM nginx:1.25.4-alpine 
#the last image could use nginx:stable-alpine and it will use the last stable image automaticlly each build , but prefared not to .

#copy the dist file could be also RUN cp but it will not work here as it's a new image 
COPY --from=node /usr/src/app/dist/client /usr/share/nginx/html
EXPOSE 80
#just for testing jenkins
