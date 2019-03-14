FROM alpine:3.9.2
MAINTAINER Hrishikesh Barman <hrishikeshbman@gmail.com>

RUN apk update
RUN apk add coova-chilli sed iptables haserl

# define build args
ARG radserver
ARG radauthport
ARG radaccport

COPY chilli.conf /etc/chilli.conf
COPY config /etc/chilli/config
COPY hs.conf /etc/chilli/hs.conf
COPY local.conf /etc/chilli/local.conf
COPY main.conf /etc/chilli/main.conf

RUN sed -i -s "s/^radiusserver1.*/radiusserver1 ${radserver}/" /etc/chilli/hs.conf
RUN sed -i -s "s/^radiusserver2.*/radiusserver2 ${radserver}/" /etc/chilli/hs.conf

EXPOSE 3990 4990 1645

ENTRYPOINT ["/usr/sbin/chilli", "--debug", "--fg"]
