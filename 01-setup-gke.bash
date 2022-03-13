#!/bin/bash

gcloud container clusters create gke-cortex --zone us-central1-a

gcloud container clusters get-credentials gke-cortex --zone us-central1-a

kubectl get nodes
