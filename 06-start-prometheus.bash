#!/bin/bash

DATA_DIR=$(pwd)
CORTEX_DOMAIN=34.102.218.51  #Change this to match ingress IP address of Cortex
INSTANCE=$(hostname)
ENV_FILE=.env
PROMETHEUS_CFG=${DATA_DIR}/prometheus/prometheus.yaml

sudo cat << EOF > ${ENV_FILE}
DATA_DIR=${DATA_DIR}
INSTANCE=${INSTANCE}
EOF

sed -i "s#__CORTEX_DOMAIN__#${CORTEX_DOMAIN}#g" ${PROMETHEUS_CFG}
sudo mkdir -p ${DATA_DIR}/prometheus

sudo docker-compose up -d --remove-orphans
