FROM  ubuntu:latest
LABEL maintainer=wallnut.monkeys@gmail.com

ARG ASTERISK_VERSION="16.1.1"

RUN apt-get update -y && apt-get install wget build-essential -y
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${ASTERISK_VERSION}.tar.gz && \
	tar -xf asterisk-${ASTERISK_VERSION}.tar.gz
ENV DEBIAN_FRONTEND=noninteractive
RUN yes | asterisk-$ASTERISK_VERSION/contrib/scripts/install_prereq install
WORKDIR /usr/src/asterisk-$ASTERISK_VERSION
RUN ./configure && make && make install && make config
#ENTRYPOINT ["/etc/init.d/asterisk", "start"]
