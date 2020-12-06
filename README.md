# OpenDJ Directory Services Helm chart

Deploy one or more OpenDJ Directory Server instances using Persistent disk claims
and StatefulSets.

## Sample Usage 

To deploy to a Kubernetes cluster:

```bash
$ helm install /
    --set replicas.count=REPLICAS_COUNT /
    --name=RELEASE_NAME /
    --namespace=TARGET_NS_NAME /
    ./opendj-helm
```

This will install a sample DS userstore.

The instance will be available in the cluster as userstore-0.

If you wish to connect an ldap browser on your local machine to this instance, you can use:

`kubectl port-forward userstore-0 1389:1389`

And open up a connection to ldap://localhost:1389

The default password is "devqaldappwd".


## Values.yaml

Please refer to values.yaml. There are a number of variables you can set on the helm command line, or
in your own custom.yaml to control the behavior of the deployment. The features described below
are all controlled by variables in values.yaml.

## Diagnostics and Troubleshooting

Use kubectl exec to get a shell into the running container. For example:

`kubectl exec userstore-0 -it bash`

There are a number of utility scripts found under `/opt/opendj/scripts`, as well as the 
directory server commands in `/opt/opendj/bin`.

use kubectl logs to see the pod logs. 

`kubectl logs userstore-0 -f`

## Scaling and replication

To scale a deployment set the number of replicas in values.yaml. See values.yaml
for the various options. Each node in the statefulset is a combined directory and replication server. Note that the topology of the set can not be changed after installation by scaling the statefulset. You can not add or remove ds nodes without reinitializing the cluster from scratch or from a backup. The desired number of ds/rs instances should be planned in advance.