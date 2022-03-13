#!/bin/bash

source .env

NS=cortex
KEY_FILE=sm.json
SA=${SA_NAME}@${PROJECT}.iam.gserviceaccount.com
SECRET=gcp-sa

kubectl create ns ${NS}

# Create service account secret
gcloud iam service-accounts keys create ${KEY_FILE} --iam-account=${SA}
kubectl delete secret ${SECRET} -n ${NS}
kubectl create secret generic ${SECRET} --from-file=gcp-sa-file=${KEY_FILE} -n ${NS}


helm repo add cortex-helm https://cortexproject.github.io/cortex-helm-chart

helm template cortex cortex-helm/cortex \
-f cortex/cortex.yaml \
--set config.blocks_storage.gcs.bucket_name=${BUCKET_NAME} \
--set config.ruler_storage.gcs.bucket_name=${BUCKET_NAME} \
--set config.alertmanager_storage.gcs.bucket_name=${BUCKET_NAME} \
--namespace ${NS} > tmp-cortex.yaml

kubectl apply -n ${NS} -f tmp-cortex.yaml

kubectl apply -n ${NS} -f cortex/cortex-ing.yaml
