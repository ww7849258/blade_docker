FROM nginx

MAINTAINER horus.wu wuwei215a@126.com

EXPOSE 80

ENV WORKPATH /app

RUN mkdir $WORKPATH

WORKDIR ${WORKPATH}

COPY . . 
RUN cp ./nginx.conf /etc/nginx/

CMD nginx -g daemon off

