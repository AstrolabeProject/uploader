FROM jupyter/base-notebook

MAINTAINER Tom Hicks <hickst@email.arizona.edu>

USER root

RUN apt-get update \
    && apt-get install -y lsb wget gnupg apt-transport-https python3.6 python-requests curl \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/*

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" > /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update \
    && apt-get install -y irods-icommands \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/* \
    && fix-permissions $CONDA_DIR

USER jovyan

# mount points for optional external user data and work volumes
RUN mkdir -p /home/jovyan/data /home/jovyan/irods

# install the iRods python client library
RUN pip install python-irodsclient

# install the Astrolabe python library
RUN pip install astrolabe_py

ENTRYPOINT ["uploader"]
CMD ["-v", "/home/jovyan/data"]
