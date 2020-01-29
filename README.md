# Ethersphere Helm Charts

[![Release](https://github.com/ethersphere/helm/workflows/Release/badge.svg)](https://github.com/ethersphere/helm/actions?query=workflow%3ARelease)

This repo contains Ethersphere Helm Charts:
* bee

## Enabling Ethersphere Helm repository

First you have to add our Helm repository like this:

```sh
$ helm repo add ethersphere https://ethersphere.github.io/helm
```

Now You can run `helm search ethersphere` to see the charts.

Note that new versions might become available and you'll have to fetch these by doing `helm repo update`.
