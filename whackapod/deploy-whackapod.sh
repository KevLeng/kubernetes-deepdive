#!/bin/bash

if [ $# -eq 1 ]; then
    # Read JSON and set it in the CREDS variable 
    DOMAIN=$1
    echo "Domain passed $DOMAIN"
else
   export PUBLIC_IP=$(curl -s ifconfig.me) 
   PUBLIC_IP_AS_DOM=$(echo $PUBLIC_IP | sed 's~\.~-~g')
   export DOMAIN="${PUBLIC_IP_AS_DOM}.nip.io"
fi

sed 's~domain.placeholder~'"$DOMAIN"'~'  ingress.template > manifests/07-ingress.yaml

kubectl apply -f manifests/