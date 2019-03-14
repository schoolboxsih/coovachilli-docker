FROM alpine:3.9.2
MAINTAINER Hrishikesh Barman <hrishikeshbman@gmail.com>

RUN apk update
RUN apk add coova-chilli

# define build args
ARG radserver
ARG radauthport
ARG radaccport

COPY chilli.conf /etc/chilli.conf
COPY config /etc/chilli/config
COPY hs.conf /etc/chilli/hs.conf
COPY local.conf /etc/chilli/local.conf
COPY main.conf /etc/chilli/main.conf

EXPOSE 3990 4990

#USER chilli

ENTRYPOINT ["/usr/sbin/chilli", "--debug", "--fg"]
