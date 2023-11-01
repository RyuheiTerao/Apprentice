FROM ubuntu:23.10

WORKDIR /code

RUN apt-get install \
    && yes | unminimize \
    && apt-get install -y man-db \
    && apt-get install -y less \
    && apt-get install -y vim
