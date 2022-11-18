FROM ghcr.io/aquasecurity/trivy:0.34.0

RUN trivy image --download-db-only
ENTRYPOINT [ "trivy", "image", "--skip-update" ]
