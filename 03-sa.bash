#!/bin/bash

source .env

gcloud iam service-accounts create ${SA_NAME} --display-name="Service account for Cortex"
