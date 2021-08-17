# Ethersphere Helm Charts

[![Release](https://github.com/ethersphere/helm/workflows/Release/badge.svg)](https://github.com/ethersphere/helm/actions?query=workflow%3ARelease)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/ethersphere)](https://artifacthub.io/packages/search?repo=ethersphere)

This repo contains Ethersphere Helm Charts:
* [bee](https://github.com/ethersphere/helm/tree/master/charts/bee)
* [beekeeper](https://github.com/ethersphere/helm/tree/master/charts/beekeeper)
* [eks-local-disk-provisioner](https://github.com/ethersphere/helm/tree/master/charts/eks-local-disk-provisioner)
* [geth-swap](https://github.com/ethersphere/helm/tree/master/charts/geth-swap)
* [tokenexporter](https://github.com/ethersphere/helm/tree/master/charts/tokenexporter)
* [ethexporter](https://github.com/ethersphere/helm/tree/master/charts/ethexporter)
* [nethermind](https://github.com/ethersphere/helm/tree/master/charts/nethermind)
* [bzz-token-service](https://github.com/ethersphere/helm/tree/master/charts/bzz-token-service)

The code is provided as-is with no warranties.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```bash
helm repo add ethersphere https://ethersphere.github.io/helm
```

Now You can run `helm search ethersphere` to see the charts.

Note that new versions might become available and you'll have to fetch these by doing `helm repo update`.
