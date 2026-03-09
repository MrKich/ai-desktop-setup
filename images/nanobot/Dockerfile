FROM python:3.14

ARG USER_ID=1000 \
    GROUP_ID=1000

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1

RUN apt update -yq && \
    apt install -yq --no-install-recommends npm && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g $GROUP_ID app && \
    useradd -d /app -g app -m -s /bin/bash -u $USER_ID app

COPY --link --from=ghcr.io/astral-sh/uv:0.10.9 /uv /usr/local/bin/
RUN uv pip install --compile-bytecode --no-cache --system nanobot-ai==v0.1.4.post4

WORKDIR /app
USER app

EXPOSE 18790
STOPSIGNAL SIGINT
CMD ["/usr/local/bin/nanobot", "gateway"]
