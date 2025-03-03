FROM continuumio/miniconda3 AS build
#
# build from ror-enabled directory as (replace name of conda_env with name used in requirements.yml):
#    docker build --no-cache --build-arg conda_env="workflow_ai_test" -f src/templates/python/DockerfileMain -t haukebartsch/fiona-component-python:latest .
#

WORKDIR /app
COPY stub.py /app/
COPY entrypoint.sh /app

#
# A derived container should do the following
#
RUN apt-get update -qq && apt-get install -y imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create the environment:
#COPY .ror/virt/requirements.yml .
#RUN conda env create -f requirements.yml

# Set value to the name of your conda environment in requirements.yml.
# Optional: provide it to docker build as a variable
#    --build-arg conda_env="workflow_ai_test"
#ARG conda_env=workflow_ai_test
ARG conda_env
ENV DEFAULT_CONDA_ENV=$conda_env

LABEL "com.ror.vendor"="MMIV.no" \
    version="1.1" \
    com.ror.conda.env.name="${DEFAULT_CONDA_ENV}" \
    description="Example docker container for workflow AI on the research information system at MMIV.no."

# Make RUN commands use the new environment:
RUN echo "conda activate ${conda_env}" >> ~/.bashr
SHELL ["/bin/bash", "--login", "-c"]

# Demonstrate the environment is activated and download weights from online:
RUN echo "Make sure diffusers are installed:"
RUN python -c "from diffusers import DiffusionPipeline;pipe = DiffusionPipeline.from_pretrained(\"stabilityai/stable-diffusion-xl-base-1.0\");pipe.load_lora_weights(\"artificialguybr/LogoRedmond-LogoLoraForSDXL-V2\")"

# The code to run when container is started:
RUN ["chmod", "+x", "/app/entrypoint.sh"]
