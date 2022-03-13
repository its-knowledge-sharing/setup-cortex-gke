#!/bin/bash

NS=cortex

source .env

helm repo add cortex-helm https://cortexproject.github.io/cortex-helm-chart

helm template cortex cortex-helm/cortex \
-f cortex/cortex.yaml \
--set config.blocks_storage.gcs.bucket_name=${BUCKET_NAME} \
--set config.ruler_storage.gcs.bucket_name=${BUCKET_NAME} \
--set config.alertmanager_storage.gcs.bucket_name=${BUCKET_NAME} \
--namespace ${NS} > tmp-cortex.yaml

kubectl apply -n ${NS} -f tmp-cortex.yaml
