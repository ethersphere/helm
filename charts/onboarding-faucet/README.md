# Onboarding faucet Helm Chart

[Onboarding faucet](https://github.com/ethersphere/onboarding-faucet) is a lightweight Prometheus proxy that will output Ethereum wallet balances from a list of addresses you specify.

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
$ helm install --generate-name ethersphere/onboarding-faucet
```

## Introduction

This chart deploys a [Onboarding faucet](https://github.com/ethersphere/onboarding-faucet) onto a Kubernetes cluster using the Helm package manager.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release ethersphere/onboarding-faucet
```

The command deploys Onboarding faucet on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

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

Create onboarding-faucet.yaml file as shown bellow:

```yaml
namespaces:
  onboarding-faucet:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  onboarding-faucet:
    name: onboarding-faucet
    namespace: onboarding-faucet
    description: "Onboarding faucet"
    chart: "ethersphere/onboarding-faucet"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f onboarding-faucet.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f onboarding-faucet.yaml 
```
