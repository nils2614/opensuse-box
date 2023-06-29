# Toolbox Image: opensuse-box
A custom openSUSE Tumbleweed Toolbox image, mainly designed for my personal use case. \
Feel free to give it a try though. :)
 
To pull this image use:
 
`podman pull ghcr.io/nils2614/opensuse-box:latest`

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

`cosign verify --key cosign.pub ghcr.io/nils2614/opensuse-box:latest`
