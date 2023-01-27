FROM ghcr.io/aquasecurity/trivy:0.36.1

RUN trivy image --download-db-only

ENTRYPOINT [ "trivy", "image", "--skip-update" ]
