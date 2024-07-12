# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This Dockerfile defines a container image that will serve as both SDK container image
# (launch environment) and the base image for Dataflow Flex Template (launch environment).
#
# For more information, see:
#   - https://cloud.google.com/dataflow/docs/reference/flex-templates-base-images
#   - https://cloud.google.com/dataflow/docs/guides/using-custom-containers


# This Dockerfile illustrates how to use a custom base image when building
# a custom contaier images for Dataflow. A 'slim' base image is smaller in size,
# but does not include some preinstalled libraries, like google-cloud-debugger.
# To use a standard image, use apache/beam_python3.11_sdk:2.54.0 instead.
# Use consistent versions of Python interpreter in the project.
FROM python:3.11-slim

# Copy SDK entrypoint binary from Apache Beam image, which makes it possible to
# use the image as SDK container image. If you explicitly depend on
# apache-beam in setup.py, use the same version of Beam in both files.
COPY --from=apache/beam_python3.11_sdk:2.57.0 /opt/apache/beam /opt/apache/beam

# Copy Flex Template launcher binary from the launcher image, which makes it
# possible to use the image as a Flex Template base image.
COPY --from=gcr.io/dataflow-templates-base/python311-template-launcher-base:flex_templates_base_image_release_20240628_RC00 /opt/google/dataflow/python_template_launcher /opt/google/dataflow/python_template_launcher

RUN pip install keyrings.google-artifactregistry-auth
RUN pip install --extra-index-url https://europe-west1-python.pkg.dev/gborel-sample-project/python-repo/simple/ gborelpy==0.3.0

# Set the entrypoint to Apache Beam SDK launcher, which allows this image
# to be used as an SDK container image.
ENTRYPOINT ["/opt/apache/beam/boot"]