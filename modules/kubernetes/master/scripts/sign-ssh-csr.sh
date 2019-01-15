#!/bin/sh -x

echo "Signing the certificate by the cluster CA"

export CA_LOCATION=/etc/kubernetes/pki/
openssl x509 -req -in .ssh/thalasoft.csr -CA $CA_LOCATION/ca.crt -CAkey $CA_LOCATION/ca.key -CAcreateserial -out .ssh/thalasoft.crt -days 1024

