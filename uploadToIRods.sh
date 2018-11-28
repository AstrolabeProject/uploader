#!/bin/bash

# Bash script to take parameters and launch the Astrolabe Uploader program.
#   Written by: Tom Hicks. 11/12/2018.
#   Last Modified: Redo to require only the data directory.
#
progname=`basename $0`

Usage() {
  echo "Usage: $progname data-directory"
  echo "where"
  echo "  data-directory is a directory containing FITS files to be uploaded to the iRods datastore"
}

if [ $# -lt 1 ]; then
  echo "Error: Please specify a data file directory containing FITS files to be uploaded"
  Usage
  exit 1
fi

DATA_DIR=${1}
if [ ! -r "$DATA_DIR" ]; then
  echo "Error: Unable to find or read the specified data directory '$DATA_DIR'"
  Usage
  exit 2
fi

echo "Uploading FITS files from '${DATA_DIR}'..."
docker run -it --rm --name uploader -v${DATA_DIR}:/home/jovyan/data hickst/uploader-de
