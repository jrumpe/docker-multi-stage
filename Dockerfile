FROM node:16-alpine3.16
### Create User static ###
COPY entrypoint.sh /root/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh
RUN apk add npm wget tar
WORKDIR /home/static/app/
RUN wget https://github.com/Roberttamaia/mobdev_ca3/archive/refs/heads/master.tar.gz
RUN tar -C . -xvf /home/static/app/master.tar.gz
RUN rm master.tar.gz
RUN printf '%s\n' *
WORKDIR /home/static/app/mobdev_ca3-master/BreakingBad/
RUN npm install -g @angular/cli @ionic/cli
RUN printf "Working Directory is : s%"pwd
RUN npm install
RUN ng build
RUN printf '%s\n' *

FROM nginx:alpine
COPY --from=0 /home/static/app/mobdev_ca3-master/BreakingBad/www/ /usr/share/nginx/html
#RUN printf '%s\n' /usr/share/nginx/html/*