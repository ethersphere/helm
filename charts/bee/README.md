# Bee Helm Chart

[Ethereum Swarm Bee](https://github.com/ethersphere/bee) is an experiment to abstract libp2p as underlay networking for Ethereum Swarm.

## QuickStart

```bash
$ helm install --generate-name ethersphere/bee
```

## Introduction

This chart deploys a [Ethereum Swarm Bee](https://github.com/ethersphere/bee) onto a Kubernetes cluster using the Helm package manager. It creates ConfigMap, Deployment and Service Kubernetes objects, while Ingress and ServiceAccount are optional.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release ethersphere/bee
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

Bee specific configuration parameters can be configured in **beeConfig** section.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set serviceAccount.create=true \
  ethersphere/bee
```

The above command creates ServiceAccount for the deployment.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml ethersphere/bee
```

## Helmsman Usage

### Prerequisites

* Kubernetes 1.15
* Helm 3.0
* Helmsman 3.0

### Installing

#### with already existing bootnode

Create bee.yaml file as shown bellow:

```yaml
namespaces:
  bee:

helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"

apps:
  bee:
    name: bee
    namespace: bee
    description: "Ethereum Swarm Bee"
    chart: "ethersphere/bee"
    version: "0.7.6"
    enabled: true
    set:
      beeConfig.bootnode: # bootnode multi address
      replicaCount: 2
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f bee.yaml 
```

#### with first pod as a bootnode

Create bee.yaml file as shown bellow:

```yaml
namespaces:
  bee:

helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"

apps:
  bee:
    name: bee
    namespace: bee
    description: "Ethereum Swarm Bee"
    chart: "ethersphere/bee"
    version: "0.7.6"
    enabled: true
    set:
      beeConfig.bootnode: "/dns4/bee-0-headless.bee.svc.cluster.local/tcp/1634/p2p/16Uiu2HAm6i4dFaJt584m2jubyvnieEECgqM2YMpQ9nusXfy8XFzL"
      libp2pSettings.enabled: true
      replicaCount: 3
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f bee.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f bee.yaml 
```
