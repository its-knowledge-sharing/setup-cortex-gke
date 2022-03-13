#!/bin/bash

NS=cortex
KEY_FILE=sm.json
SA=${VAR_EXT_SECRET_SA}
SECRET=gcp-sa

echo "####"
echo "#### Deploying cortex to [${NS}] ####"

kubectl create ns ${NS}

OUTPUT_FILE=cortex-ext-secret.yaml
sed -i "s#<<VAR_PROMETHEUS_SECRET_PROJECT>>#${VAR_PROMETHEUS_SECRET_PROJECT}#g" ${OUTPUT_FILE}
kubectl apply -f ${OUTPUT_FILE} -n ${NS}

# Create service account secret
if [ -f "${KEY_FILE}" ]; then
    echo "File ${KEY_FILE} already exists. So, do nothing!!!"
else 
    gcloud iam service-accounts keys create ${KEY_FILE} --iam-account=${SA}
fi
kubectl delete secret ${SECRET} -n ${NS}
kubectl create secret generic ${SECRET} --from-file=gcp-sa-file=${KEY_FILE} -n ${NS}


OUTPUT_FILE=rendered-cortex.yaml
kubectl apply -f ${OUTPUT_FILE} -n ${NS}

OUTPUT_FILE=cortex-ing.yaml
sed -i "s#<<VAR_NGINX_DOMAIN>>#${VAR_NGINX_DOMAIN}#g" ${OUTPUT_FILE}
kubectl apply -f ${OUTPUT_FILE} -n ${NS}
