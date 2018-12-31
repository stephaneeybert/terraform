echo Configuring a user in the client

cd
mkdir -p .ssh

echo Copying the key and the certificate to the client
scp -o "StrictHostKeyChecking no" root@${MASTER_IP}:.ssh/thalasoft.* .ssh/

echo Configuring the client with a user credentials
kubectl config set-credentials stephane --client-certificate=.ssh/thalasoft.crt  --client-key=.ssh/thalasoft.key

echo Creating a context, that is, a user against a namespace of a cluster, in the client configuration
kubectl config set-context digital-ocean-context --cluster=digital-ocean-cluster --namespace=digital-ocean-namespace --user=stephane

echo Changing the current context
kubectl config use-context digital-ocean-context
