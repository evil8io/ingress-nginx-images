# ingress-nginx-images

Container images of the ingress-nginx controller for `linux/amd64` and `linux/arm64`.

The Kubernetes project archived [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx) in March 2026.
These images are based on the ingress-nginx [fork](https://github.com/chainguard-forks/ingress-nginx) maintained by
Chainguard.

## Usage

```
ghcr.io/evil8io/images/ingress-nginx/controller:<version>
```

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
