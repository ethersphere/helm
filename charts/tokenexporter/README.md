# Tokenexporter Helm Chart

[Tokenexporter](https://github.com/ethersphere/tokenexporter) is a lightweight Prometheus exporter that will output ERC20 Token balances from a list of addresses you specify.

## QuickStart

```bash
$ helm install --generate-name ethersphere/tokenexporter
```

## Introduction

This chart deploys a [Tokenexporter](https://github.com/ethersphere/tokenexporter) onto a Kubernetes cluster using the Helm package manager.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release ethersphere/tokenexporter
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

Create tokenexporter.yaml file as shown bellow:

```yaml
namespaces:
  tokenexporter:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  tokenexporter:
    name: tokenexporter
    namespace: tokenexporter
    description: "Tokenexporter"
    chart: "ethersphere/tokenexporter"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f tokenexporter.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f tokenexporter.yaml 
```
