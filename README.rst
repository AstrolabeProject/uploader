Docker image for the Astrolabe Uploader Program
===============================================

:Version: 1.0.1
:Author: Tom Hicks <hickst@email.arizona.edu>

This project contains the files necessary to build a Docker image
for the `Astrolabe project <http://astrolabe.arizona.edu/>`_
Uploader program. The resulting image allows a user to upload FITS files from a
local disk to a Cyverse iRods data storage node. As part of the upload, FITS header
metadata is extracted from each FITS file and attached to the corresponding iRods file.


Use the script to upload FITS files
-----------------------------------

To upload files from your local disk to iRods, this project provides the
``uploadToIRods.sh`` Bash script which, in turn, just uses the existing
`DockerHub image <https://hub.docker.com/r/hickst/uploader>`_

**You must have Docker installed locally on your machine before you can
invoke the Bash script.** Once Docker is installed and activated,
download the ``uploadToIRods.sh`` Bash script.

To upload FITS files to iRods, run the script and point it at a directory tree containing
one or more FITS files. Before the upload begins you will be asked for your Cyverse iRods
username and password.

**Note that the directory path specified to the Bash script must be an absolute path
(and should NOT include '.' or '..').**
To specify a child directory of the current directory, prefix the directory name with
${PWD}, as shown in the examples below.

Files and directories will be uploaded to a sub-directory of your home iRods storage space
named ``astrolabe/data``. Any nested and intermediate directories will be created on the
iRods data store, but only if they ultimately contain at least one FITS file. Nested
directories that do not contain FITS files will not be recreated on the iRods data store.


Examples::

  > uploadToIRods.sh /Users/astroguy/data
  > uploadToIRods.sh $PWD/data
  > uploadToIRods.sh /data/astro/m13/optical
  > uploadToIRods.sh /tmp


Building and running manually
-----------------------------

Building this software requires ``Docker 18+`` and follows the normal
Docker build procedure::

   git clone https://github.com/AstrolabeProject/uploader.git
   cd uploader
   docker build -t uploader .

A local instance of the Uploader image may then be invoked, as in the following example,
which uploads all FITS files from the ``astrodata`` directory and any child directories::

  docker run -it --rm --name uploader -v${PWD}/astrodata:/home/jovyan/data uploader


License
-------

Licensed under Apache License Version 2.0.

Copyright 2018 by Astrolabe Project: American Astronomical Society and the University of Arizona.
