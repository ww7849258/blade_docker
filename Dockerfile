FROM ruby:1.9.3
MAINTAINER horus.wu wuwei215a@126.com
RUN  apt-get update && apt-get install -qq -y git vim libmagickwand-dev imagemagick libmagickcore-dev

EXPOSE 80

ENV INSTALL_PATH=/app \
    DATABASE_USERNAME=root \
    DATABASE_PASSWORD=root \
    DATABASE_HOST=blade-db \
    DATABASE_DB_NAME=blade \
    RAILS_ENV=development \
    REDIS_HOST=blade-redis 

RUN mkdir $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY . .

RUN gem install debugger-ruby_core_source && \
gem install debugger -v '1.5.0'

RUN bundle install
RUN mkdir -p /app/tmp/pids
CMD puma -d -C config/puma.rb -p 80 && tail -f log/*.log
