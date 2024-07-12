#!/bin/bash

# Exit when any command fails
set -euo pipefail

PROJECT=gborel-sample-project
REGION=europe-west1
# No uppercase letters
PIPELINE=dataflow-base-image
TAG=1.0.0
CONTAINER_IMAGE="$REGION-docker.pkg.dev/$PROJECT/dataflow-images/$PIPELINE:$TAG"

# Build and push Docker image to Artifact Registry
gcloud builds submit --tag $CONTAINER_IMAGE . 