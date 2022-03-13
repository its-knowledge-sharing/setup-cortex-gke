#!/bin/bash

gsutil mb -b on -l us-central1-a gs://${BUCKET_NAME}/

gsutil ls gs://${BUCKET_NAME}/
