FROM ghcr.io/aquasecurity/trivy:latest

RUN wget https://github.com/aquasecurity/trivy-db/releases/latest/download/trivy-offline.db.tgz && \
    tar -zxvf trivy-offline.db.tgz && rm -rf trivy-offline.db.tgz && \
    mkdir -p /root/.cache/trivy/db && \
    mv trivy.db /root/.cache/trivy/db/  && \
    mv metadata.json /root/.cache/trivy/db/

ENTRYPOINT [ "trivy", "--skip-update" ]
