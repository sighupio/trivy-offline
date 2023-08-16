FROM ghcr.io/aquasecurity/trivy:0.44.1

RUN trivy image --download-db-only && trivy image --download-java-db-only

ENTRYPOINT [ "trivy", "image", "--skip-db-update", "--skip-java-db-update" ]
