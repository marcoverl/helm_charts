# Apache Spark Helm Chart

Apache Spark is a fast and general-purpose cluster computing system.

* http://spark.apache.org/

## Chart Details
This chart will do the following:

* 1 x Spark Master with port 30808 exposed with a nodePort service (webUi)
* 1 x Jupyter notebook with port 30888 exposed with a nodePort service, with 2 executors
* All using Kubernetes Deployments

## Prerequisites


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release stable/spark
```

## Configuration

The following table lists the configurable parameters of the Spark chart and their default values.

### Spark Master

| Parameter               | Description                        | Default                                                    |
| ----------------------- | ---------------------------------- | ---------------------------------------------------------- |
| `master.name`           | Spark master name                  | `master`                                             |
| `master.image`          | Container image name               | `cloudpg/spark-py`                                         |
| `master.imageTag`       | Container image tag                | `dodas-2.4.3-bigdl`                                                 |
| `master.replicas`       | k8s deployment replicas            | `1`                                                        |
| `master.component`      | k8s selector key                   | `spark-master`                                             |
| `master.cpu`            | container requested cpu            | `100m`                                                     |
| `master.memory`         | container requested memory         | `1024Mi`                                                    |
| `master.servicePort`    | k8s service port                   | `7077`                                                     |
| `master.containerPort`  | Container listening port           | `7077`                                                     |
| `master.daemonMemory`   | Master JVM Xms and Xmx option      | `1g`                                                       |
| `master.serviceType `   | Kubernetes Service type            | `nodePort`                                             |
| `master.jupyter.nodePort`| k8s node port                     | `30888`                                                 |
| `master.jupyter.token`  | Token for jupyter notebook         | `testme`                                                   |
| `hostpath.path`         | Path where to store volumes        | `/tmp`                                                     |

### Spark WebUi

|       Parameter       |           Description            |                         Default                          |
|-----------------------|----------------------------------|----------------------------------------------------------|
| `webUi.name`          | Spark webui name                 | `webui`                                                  |
| `webUi.servicePort`   | k8s service port                 | `8080`                                                   |
| `webUi.containerPort` | Container listening port         | `8080`                                                   |
| `webUi.serviceType `   | Kubernetes Service type         | `nodePort`                                             |
| `webUi.nodePort`       | k8s node port                   | `30808`                                                 |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm repo add dodas https://dodas-ts.github.io/helm_charts
$ helm repo update
$ helm install --name my-release -f values.yaml dodas/spark
```

> **Tip**: You can use the default [values.yaml](values.yaml)

