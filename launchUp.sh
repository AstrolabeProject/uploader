#!/bin/bash

# Bash script to take parameters and launch the Astrolabe Uploader program.
#   Written by: Tom Hicks. 11/12/2018.
#
progname=`basename $0`

IRODS_ENV_JSON=irods_environment.json
IRODS_PASSWORD=.irodsA

Usage() {
  echo "Usage: $progname irods-directory data-directory"
  echo "where"
  echo "    irods-directory: a directory containing iRods configuration files (usually: ~/.irods)"
  echo "     data-directory: a directory containing FITS files to be uploaded to the datastore"
  exit 1
}

hasIrodsConfigFiles () {
  if [ ! -d "$1" ]; then
    return 1
  elif [ ! -r "${1}/${IRODS_ENV_JSON}" ]; then
    return 2
  elif [ ! -r "${1}/${IRODS_PASSWORD}" ]; then
    return 3
  else
    return 0
  fi
}

if [ $# -lt 2 ]; then
  echo "Error: Please specify the iRods configuration file directory and data file directory"
  Usage
fi

DATA_DIR=${2}
if [ ! -d "$DATA_DIR" ]; then
  echo "Error: Unable to find or read the specified data directory '$DATA_DIR'"
  Usage
fi

IRODS_DIR=${1}
hasIrodsConfigFiles "$IRODS_DIR"
case "$?" in
  0) ;;
  1)
    echo "Error: Unable to find or read the specified iRods configuration directory '$IRODS_DIR'"
    Usage
    ;;
  2)
    echo "Error: The file '${IRODS_ENV_JSON}' is missing from the iRods configuration directory '$IRODS_DIR'"
    exit 2
    ;;
  3)
    echo "Error: The file '${IRODS_PASSWORD}' is missing from the iRods configuration directory '$IRODS_DIR'"
    exit 3
    ;;
esac

echo "IRODS: ${IRODS_DIR}"
echo " DATA: ${DATA_DIR}"

echo docker run -it --name upl$$ -v${IRODS_DIR}:/home/jovyan/.irods -v${DATA_DIR}:/home/jovyan/data uploader-de
docker container ls -a
