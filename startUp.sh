#!/bin/bash

# Bash script launch the Astrolabe Uploader program from within a Docker image.
#   Written by: Tom Hicks. 11/20/2018.
#
progname=`basename $0`

IRODS_DIR=.irods
IRODS_ENV_JSON=irods_environment.json
ROOT_DIR=/home/jovyan

# Creates a partial, default iRods environment file.
init_icmds ()
{
  mkdir -p ${ROOT_DIR}/${IRODS_DIR}
  cat > ${ROOT_DIR}/${IRODS_DIR}/${IRODS_ENV_JSON}  <<ICMDS_JSON
{
    "irods_host": "data.cyverse.org",
    "irods_port": 1247,
    "irods_user_name": "$IPLANT_USER",
    "irods_zone_name": "iplant"
}
ICMDS_JSON
}

echo "Creating iRods environment files..."
init_icmds

echo "Running iinit..."
iinit

echo "Running Uploader..."
exec uploader -v ${ROOT_DIR}/data
