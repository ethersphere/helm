# Bee localchain Helm Chart

[Bee localchain](https://github.com/ethersphere/bee-localchain) is a lightweight single node blockchain, based on hardhat, used for Bee development environments.

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
$ helm install --generate-name ethersphere/bee-localchain
```

## Introduction

This chart deploys a [Bee localchain](https://github.com/ethersphere/bee-localchain) onto a Kubernetes cluster using the Helm package manager.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release ethersphere/bee-localchain
```

The command deploys Bee localchain on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

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

Create bee-localchain.yaml file as shown bellow:

```yaml
namespaces:
  bee-localchain:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  bee-localchain:
    name: bee-localchain
    namespace: bee-localchain
    description: "Bee localchain"
    chart: "ethersphere/bee-localchain"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f bee-localchain.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f bee-localchain.yaml 
```
