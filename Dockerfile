FROM ubuntu:18.04

MAINTAINER Tom Hicks <hickst@email.arizona.edu>

USER root

RUN apt-get update \
    && apt-get install -y lsb wget gnupg curl apt-transport-https \
    && apt-get install -y python3.6 python-requests python3-pip \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/*

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" > /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update \
    && apt-get install -y irods-icommands \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/*

# install the iRods python client library
RUN pip3 install python-irodsclient

# install the Astrolabe python library
RUN pip3 install astrolabe_py

# mount points for external user data and iRods configuration volumes
RUN mkdir -p /data /.irods

# copy in the wrapper shell and run it
COPY startUp.sh /startUp.sh

ENTRYPOINT ["/startUp.sh"]
