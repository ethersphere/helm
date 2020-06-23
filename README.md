# Ethersphere Helm Charts

[![Release](https://github.com/ethersphere/helm/workflows/Release/badge.svg)](https://github.com/ethersphere/helm/actions?query=workflow%3ARelease)

This repo contains Ethersphere Helm Charts:
* [bee](https://github.com/ethersphere/helm/tree/master/charts/bee)
* [beekeeper](https://github.com/ethersphere/helm/tree/master/charts/beekeeper)
* [eks-local-disk-provisioner](https://github.com/ethersphere/helm/tree/master/charts/eks-local-disk-provisioner)
* [geth-swap](https://github.com/ethersphere/helm/tree/master/charts/geth-swap)

## Enabling Ethersphere Helm repository

First you have to add our Helm repository like this:

```sh
$ helm repo add ethersphere https://ethersphere.github.io/helm
```

Now You can run `helm search ethersphere` to see the charts.

Note that new versions might become available and you'll have to fetch these by doing `helm repo update`.
