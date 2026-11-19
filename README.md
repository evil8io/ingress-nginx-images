# ingress-nginx-images

Multi-arch container images of the ingress-nginx controller, built from the Chainguard fork with its security fixes.

The Kubernetes project archived [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx) in March 2026,
so its images no longer receive security fixes. Chainguard maintains a
[fork](https://github.com/chainguard-forks/ingress-nginx) with security fixes, but publishes only the source. We build
the controller image from each release of the fork.

## Usage

```
ghcr.io/evil8io/images/ingress-nginx/controller:<version>
```

`<version>` is a release of the fork, for example `v1.15.16` for `controller-v1.15.16`. Each image supports
`linux/amd64` and `linux/arm64`.

With the ingress-nginx Helm chart:

```yaml
controller:
  image:
    registry: ghcr.io/evil8io/images
    tag: v1.15.16
    digest: ""
```

## License

[Apache License 2.0](LICENSE). The image also contains third-party software under other licenses, including the GPL.
The fork and [Alpine Linux](https://gitlab.alpinelinux.org/alpine/aports) list the sources.

This repository is not affiliated with, or endorsed by, Chainguard, the Kubernetes project, or F5.
