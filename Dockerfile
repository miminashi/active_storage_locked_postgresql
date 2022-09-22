#
# ビルド用ステージ
#
FROM ruby:3.1.2-slim-bullseye as builder

ENV DEBIAN_FRONTEND noninteractive
ENV APPROOT="/opt/app"

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential postgresql libpq-dev && \
    apt-get clean

WORKDIR ${APPROOT}

COPY Gemfile ${APPROOT}
RUN gem install bundler && bundle install

COPY . ${APPROOT}

#
# 実行用ステージ
#
FROM ruby:3.1.2-slim-bullseye

ENV DEBIAN_FRONTEND noninteractive
ENV APPROOT="/opt/app"
ENV RAILS_LOG_TO_STDOUT="1"

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install postgresql libvips42 youtube-dl && \
    apt-get clean

COPY --from=builder /usr/local/bundle /usr/local/bundle

WORKDIR ${APPROOT}
