#!/bin/bash

# Bash script to take parameters and launch the Astrolabe Uploader program.
#   Written by: Tom Hicks. 11/12/2018.
#   Last Modified: Update for rebase on Ubuntu. Better data dir checking. Expand data dir path.
#
progname=`basename $0`

Usage() {
  echo "Usage: $progname data-directory [irods-username]"
  echo "where"
  echo "  data-directory is a directory containing FITS files to be uploaded to the iRods datastore"
  echo "  irods-username is your Cyverse username (defaults to your current username on this host)"
}

if [ $# -lt 1 ]; then
  echo "Error: Please specify a data file directory containing FITS files to be uploaded"
  Usage
  exit 1
fi

DATA_DIR=${1}
if [ ! -d "$DATA_DIR" ]; then
  echo "Error: the specified data directory '$DATA_DIR' does not exist or is not a directory"
  Usage
  exit 2
fi
if [ ! -r "$DATA_DIR" ]; then
  echo "Error: the specified data directory '$DATA_DIR' is not readable"
  Usage
  exit 3
fi
DATA_PATH=$(cd ${DATA_DIR} && pwd)

IUSER=${2:-$USER}

echo "Uploading FITS files from '${DATA_PATH}' for user '${IUSER}'..."
docker run -it --rm --name uploader -e IPLANT_USER=${IUSER} -v ${DATA_PATH}:/data hickst/uploader
