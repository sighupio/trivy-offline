FROM ghcr.io/aquasecurity/trivy:latest

RUN trivy i --download-db-only
ENTRYPOINT [ "trivy", "i", "--skip-update" ]
