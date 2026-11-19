# ingress-nginx-images

Container images of the ingress-nginx controller, built from the Chainguard fork and its NGINX security backports.

## Why

The Kubernetes project archived [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx) on March 24, 2026.
The images on `registry.k8s.io` no longer receive security fixes.

Chainguard maintains a [fork](https://github.com/chainguard-forks/ingress-nginx) with best-effort fixes for publicly
known vulnerabilities. The fixes include backports of NGINX security fixes to the NGINX version that the controller
bundles.
The fork has source releases, but it does not have public container images.

We build the controller image from each release of the fork and publish it on GHCR:

```
ghcr.io/evil8io/images/ingress-nginx/controller:<version>
```

Each image is multi-arch: `linux/amd64` and `linux/arm64`.

## Usage

`<version>` is the release tag of the fork without the `controller-` prefix. The release `controller-v1.15.16` is the
image tag `v1.15.16`.

The image path ends in `ingress-nginx/controller`, the default image name of the ingress-nginx Helm chart. With the
chart, change only the registry and the tag:

```yaml
controller:
  image:
    registry: ghcr.io/evil8io/images
    tag: v1.15.16
    digest: ""
```

Set `digest` to an empty string, because some chart versions set the digest of the `registry.k8s.io` image by default.

We build only the controller image. We do not build the chroot variant or the other images of the chart, for example
`kube-webhook-certgen`.

## Build and versioning

GitHub runs the workflow `build.yaml` daily. The workflow takes the highest `controller-vX.Y.Z` tag of the fork and
builds the image when that version is not on GHCR yet.

Each build compiles NGINX from the source of the release tag, with all patches of the fork, and builds the controller
image on top of it. The `NGINX_BASE` file of the fork still contains the upstream base image of March 2026 on
`registry.k8s.io`, which is older than the backports of the fork. The workflow does not use that image. The build fails
when the controller image is not built on the NGINX base image of the same run.

The build differs from the build files of the fork in three points:

- The Go toolchain is the latest patch release of the minor version in `GOLANG_VERSION`.
- The image contains a copy of the Apache License 2.0 at `/licenses/LICENSE`.
- The labels `org.opencontainers.image.vendor`, `org.opencontainers.image.source`, and `org.opencontainers.image.url`
  refer to this repository and to the fork.

Manual build of a specific release:

```sh
gh workflow run build.yaml -f tag=controller-v1.15.16
```

A manual build replaces the tag `<version>`. It also installs the current Alpine package updates into a version that is
already published. Pin the image by digest when you need a fixed image.

When the last commit on `main` is older than 50 days, the workflow pushes an empty keepalive commit, because GitHub
disables scheduled workflows after 60 days without repository activity.

## Relationship to upstream

We repackage [chainguard-forks/ingress-nginx](https://github.com/chainguard-forks/ingress-nginx) in this repository.
This repository is not affiliated with, or endorsed by, Chainguard, the Kubernetes project, or F5. Chainguard offers
its own container images of the project; see the README of the fork.

## License

The files in this repository are licensed under the [Apache License 2.0](LICENSE). The ingress-nginx source has the
same license.

The image also contains software under other licenses:

- NGINX and the modules that the script `images/nginx/rootfs/build.sh` of the fork compiles. That script pins the
  version and the download URL of each source. One of them, ssdeep, is licensed under GPL-2.0.
- Alpine Linux packages. Among them are busybox and apk-tools (GPL-2.0-only), and bash, patch, and diffutils
  (GPL-3.0-or-later). The build recipes, with the location of each source, are in the
  [aports](https://gitlab.alpinelinux.org/alpine/aports) repository of Alpine Linux.
