ARG CONTROLLER_IMAGE

FROM ${CONTROLLER_IMAGE}

LABEL org.opencontainers.image.vendor="Evil8 B.V."
LABEL org.opencontainers.image.source="https://github.com/chainguard-forks/ingress-nginx"
LABEL org.opencontainers.image.url="https://github.com/evil8io/ingress-nginx-images"

COPY LICENSE /licenses/LICENSE
