FROM ghcr.io/aquasecurity/trivy:latest

RUN trivy image --download-db-only
ENTRYPOINT [ "trivy", "image", "--skip-update" ]
