# BZZ Token Service Helm Chart

[BZZ Token Service](https://github.com/ethersphere/bzz-token-service) is a lightweight Prometheus proxy that will output Ethereum wallet balances from a list of addresses you specify.

## Prerequisites

Make sure you have Helm [installed](https://helm.sh/docs/intro/install/) installed.

## Get Repo Info

```bash
helm repo add ethersphere https://ethersphere.github.io/helm
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## QuickStart

```bash
$ helm install --generate-name ethersphere/bzz-token-service
```

## Introduction

This chart deploys a [BZZ Token Service](https://github.com/ethersphere/bzz-token-service) onto a Kubernetes cluster using the Helm package manager.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release ethersphere/bzz-token-service
```

The command deploys BZZ Token Service on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The default configuration values for this chart are listed in **values.yaml**.

## Helmsman Usage

### Prerequisites

* Kubernetes 1.15
* Helm 3.0
* Helmsman 3.0

### Installing

Create bzz-token-service.yaml file as shown bellow:

```yaml
namespaces:
  bzz-token-service:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  bzz-token-service:
    name: bzz-token-service
    namespace: bzz-token-service
    description: "BZZ Token Service"
    chart: "ethersphere/bzz-token-service"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f bzz-token-service.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f bzz-token-service.yaml 
```
