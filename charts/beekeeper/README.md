# Beekeeper Helm Chart

[Ethereum Swarm Beekeeper](https://github.com/ethersphere/beekeeper) is tool used for testing of [Ethereum Swarm Bee](https://github.com/ethersphere/bee).

## QuickStart

```bash
$ helm install --generate-name ethersphere/beekeeper
```

## Introduction

This chart deploys a [Ethereum Swarm Beekeeper](https://github.com/ethersphere/beekeeper) onto a Kubernetes cluster using the Helm package manager.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release ethersphere/beekeeper
```

The command deploys Bee on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

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

Create beekeeper.yaml file as shown bellow:

```yaml
namespaces:
  beekeeper:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  beekeeper:
    name: beekeeper
    namespace: beekeeper
    description: "Ethereum Swarm Beekeeper"
    chart: "ethersphere/beekeeper"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f beekeeper.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f beekeeper.yaml 
```
