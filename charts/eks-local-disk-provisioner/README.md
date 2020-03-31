# AWS EKS local-disk-provisioner Helm Chart

## QuickStart

```bash
$ helm install --generate-name ethersphere/eks-local-disk-provisioner
```

## Introduction

This chart deploys a [eks-local-disk-provisioner](https://github.com/ethersphere/eks-local-disk-provisioner) onto a Kubernetes cluster using the Helm package manager. It creates DaemonSet Kubernetes object, while ServiceAccount is optional.

## Prerequisites

* Kubernetes 1.15
* Helm 3.0

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release ethersphere/eks-local-disk-provisioner
```

The command deploys eks-local-disk-provisioner on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The default configuration values for this chart are listed in **values.yaml**.

eks-local-disk-provisioner specific configuration parameters can be configured in **provisionerConfig** section.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set serviceAccount.create=true \
  ethersphere/eks-local-disk-provisioner
```

The above command creates ServiceAccount for the DaemonSet.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml ethersphere/eks-local-disk-provisioner
```

## Helmsman Usage

### Prerequisites

* Kubernetes 1.15
* Helm 3.0
* Helmsman 3.0

### Installing

Create eks-local-disk-provisioner.yaml file as shown bellow:

```yaml
namespaces:
  kube-system:
    
helmRepos:
  ethersphere: "https://ethersphere.github.io/helm"
    
apps:
  eks-local-disk-provisioner:
    name: eks-local-disk-provisioner
    namespace: kube-system
    description: "AWS EKS Local Disk Provisioner"
    chart: "ethersphere/eks-local-disk-provisioner"
    version: "0.1.0"
    enabled: true
    wait: true
    timeout: 120

```

Execute following command:
```bash
$ helmsman -apply -f eks-local-disk-provisioner.yaml 
```

### Uninstalling

Execute following command:
```bash
$ helmsman -destroy -f eks-local-disk-provisioner.yaml 
```
