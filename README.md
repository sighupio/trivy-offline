# Trivy Offline

[![Build Status](https://ci.sighup.io/api/badges/sighupio/trivy-offline/status.svg)](https://ci.sighup.io/sighupio/trivy-offline)

![Trivy Logo](https://raw.githubusercontent.com/aquasecurity/trivy/master/imgs/logo.png)

This project aims to solve an issue while using [trivy] at scale.
In an environment where you need to scan hundreds or even thousands of container images with [trivy], you can hit a
GitHub limit while downloading the vulnerability database.

## Inspiration

This project was inspired by the [`arminc/clair-db`](https://hub.docker.com/r/arminc/clair-db) container image
and [github.com/arminc/clair-local-scan](https://github.com/arminc/clair-local-scan) project witch speeds up
[clair](https://github.com/quay/clair) vulnerability scans.

## What we do

We build and publish a new container image every day following
[trivy documentation to download and use the vulnerability database just once](https://github.com/aquasecurity/trivy/blob/master/docs/air-gap.md).
The process was designed to be used in air-gapped environment but it fits perfectly while running this software on CI
systems like `drone`, `gitlab`, `github-actions`, `circle-ci`, or `travis`.

We publish two different tags every day:

- `quay.io/sighup/trivy-offline`:**latest**: It is overridden every day. If you choose this tag, be sure to pull the image before running your scan.
- `quay.io/sighup/trivy-offline`:**`YYYY-MM-DD`**: It is just one every day. We recommend you to use this tag. It is published at 01:00 UTC Time.

## Quick Start

```bash
# Don't forget to pull before run
$ docker pull quay.io/sighup/trivy-offline
$ docker run --rm quay.io/sighup/trivy-offline [YOUR_IMAGE_NAME]
# or
$ docker run --rm quay.io/sighup/trivy-offline:$(date +%Y-%m-%d) [YOUR_IMAGE_NAME]
```

If you would like to scan the image on your host machine, you need to mount `docker.sock`.

```bash
# Don't forget to pull before run
$ docker pull quay.io/sighup/trivy-offline
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    quay.io/sighup/trivy-offline python:3.4-alpine
# or
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    quay.io/sighup/trivy-offline:$(date +%Y-%m-%d) python:3.4-alpine

```

Please re-pull latest `quay.io/sighup/trivy-offline` if an error occurred.

[trivy](https://github.com/aquasecurity/trivy)
