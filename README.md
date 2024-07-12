# dataflow_docker_base_image
This Docker image serves as a light base image for Dataflow Flex Templates pipelines.

It contains:
- A light Python 3.11 environment
- Apache Beam 2.57.0 Python SDK
- A Python package from Artifact Registry
- `protoc` in order to compile `.proto` files

You can use it in your Dockerfile like this:

```
FROM europe-west1-docker.pkg.dev/gborel-sample-project/dataflow-images/dataflow-base-image:1.0.0
```

## Build
Set the variables in the script and then run it:
```bash
./build.sh
```