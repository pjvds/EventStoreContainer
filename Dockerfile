# Container running Eventstore
#
# VERSION               0.1
FROM ubuntu
MAINTAINER Pieter Joost van de Sande "pj@born2code.net"

# make sure the package repository is up to date
RUN apt-get update

# install packages required to build mono and the eventstore
RUN apt-get install -y mono

# setup directory structure
ENV EVENTSTORE_BLD /var/local/EventStore/bin/eventstore/release/anycpu
ENV EVENTSTORE_ROOT /opt/eventstore
ENV EVENTSTORE_BIN /opt/eventstore/bin
ENV EVENTSTORE_DB /opt/eventstore/db
ENV EVENTSTORE_LOG /opt/eventstore/logs

# create directory structure
RUN mkdir -p $EVENTSTORE_ROOT
RUN mkdir -p $EVENTSTORE_BIN
RUN mkdir -p $EVENTSTORE_DB
RUN mkdir -p $EVENTSTORE_LOG

# Copy eventstore bin into the container
ADD eventsource-bin /opt/eventstore/bin

EXPOSE 2113:2113
EXPOSE 1113:1113

# set entry point to eventstore executable
ENTRYPOINT ["mono-sgen", "/opt/eventstore/bin/EventStore.SingleNode.exe", "--log=/opt/eventstore/logs", "--db=/opt/eventstore/db"]

# bind it to all interfaces by default
CMD ["--ip=127.0.0.1", "--http-prefix=http://*:2113/"]
