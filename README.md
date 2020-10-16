# Trivy Offline

[![Build Status](https://ci.sighup.io/api/badges/sighupio/trivy-offline/status.svg)](https://ci.sighup.io/sighupio/trivy-offline)

<a href="https://github.com/aquasecurity/trivy" target="_blank"><img src="https://raw.githubusercontent.com/aquasecurity/trivy/master/imgs/logo.png" width="150"></a>

This project aims to solve an issue while using [trivy] at scale.
In an environment where you need to scan hundreds or even thousands of container images with [trivy], you can hit a
GitHub limit while downloading the vulnerability database.

## Inspiration

This project was inspired by the [`arminc/clair-db`](https://hub.docker.com/r/arminc/clair-db) container image,
and [github.com/arminc/clair-local-scan](https://github.com/arminc/clair-local-scan) project witch speeds up
[clair](https://github.com/quay/clair) vulnerability scans.

## What we do

We build and publish a new container image every day following
[trivy documentation to download and use the vulnerability database just once](https://github.com/aquasecurity/trivy/blob/master/docs/air-gap.md).
The process was designed to be used in the air-gapped environment. Still, it fits perfectly while running this software on CI
systems like `drone`, `gitlab`, `github-actions`, `circle-ci`, or `travis`.

We publish two different tags every day:

- *[quay.io/sighup/trivy-offline]*:`latest`: It is overridden every day. If you choose this tag, be sure to pull the image before running your scan.
- *[quay.io/sighup/trivy-offline]*:`YYYY-MM-DD`: It is just one every day. We recommend you to use this tag. It is published at 01:00 UTC Time.

## Quick Start

```bash
# Don't forget to pull before running
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

Please re-pull latest [`quay.io/sighup/trivy-offline`] if an error occurred.

### CI Example - drone ci

You can scan your container images *(or anyone public available)* on drone ci. [See an example below](.drone.yml):

```yaml
---
kind: pipeline
name: example

steps:
  - name: scan
    image: quay.io/sighup/trivy-offline:latest
    pull: always
    commands:
      - trivy --skip-update python:3.4-alpine
```

### CI Example - gitlab ci

You can include [gitlab.yml](gitlab.yml) in your .gitlab-ci.yml.

Here trivy is defined as a hidden job so it can be extended in any job in any stage any number of times in the same pipeline. 

You can scan your own public/private container images *(or anyone public available)* on gitlab ci.

By default *CI_REGISTRY, CI_REGISTRY_USER & CI_REGISTRY_PASSWORD* are used to fetch private docker image if *TRIVY_AUTH_URL, TRIVY_USERNAME & TRIVY_PASSWORD* variables are not defined.

In this example, by default trivy will scan the docker image *(${CI_REGISTRY_IMAGE}/${CI_COMMIT_REF_NAME})* in the container registry of the repo for the branch pipeline is running for,

```yaml
include:
  - remote: 'https://raw.githubusercontent.com/sighupio/trivy-offline/master/gitlab.yml'

trivy:
  extends: .trivy
  stage: scan
```

And, in this example we are passing the docker image manually.

```yaml
trivy:
  extends: .trivy
  stage: scan
  script:
    - |
      # node:alpine...
      trivy --skip-update node:alpine
```

[trivy]: https://github.com/aquasecurity/trivy
[quay.io/sighup/trivy-offline]: https://quay.io/sighup/trivy-offline
[`quay.io/sighup/trivy-offline`]: https://quay.io/sighup/trivy-offline
