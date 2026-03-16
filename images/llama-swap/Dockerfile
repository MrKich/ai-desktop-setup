FROM ghcr.io/mostlygeek/llama-swap:v198-cuda-b8352

RUN apt update -yq && \
    apt install -y --no-install-recommends \
      docker.io \
      docker-compose-v2 && \
    rm -rf /var/lib/apt/lists/*
