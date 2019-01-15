#!/bin/sh -x

echo "Creating an SSH private key and a certificate signing request"

echo "Creating a private key"
openssl genrsa -out .ssh/thalasoft.key 4096

echo "Creating a certificate signing request"
openssl req -new -key .ssh/thalasoft.key -out .ssh/thalasoft.csr -subj "/CN=stephane/O=thalasoft"

