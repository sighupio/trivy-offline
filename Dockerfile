FROM ghcr.io/aquasecurity/trivy:latest

RUN trivy --download-db-only
ENTRYPOINT [ "trivy", "i", "--skip-update" ]
