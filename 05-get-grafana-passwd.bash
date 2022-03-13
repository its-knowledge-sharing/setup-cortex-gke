#!/bin/bash

kubectl get secret grafana-cortex \
-n grafana-cortex \
-o jsonpath="{.data.admin-password}" | base64 --decode
