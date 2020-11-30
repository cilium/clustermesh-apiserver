# **DEPRECATED: This repository is deprecated.**

The code can be found in https://github.com/cilium/cilium/tree/master/clustermesh-apiserver

# API server for Cilium ClusterMesh

## Deploy the clustermesh-apiserver

1. Adjust `install/deployment.yaml` and modify the service type to either
   `LoadBalancer` or `NodePort` depending on your needs.

2. Enable SSL transport security features in the etcd container as needed. See
   the  [etcd documentation](https://etcd.io/docs/v3.4.0/op-guide/security/)
   for details.

3. Deploy the `clustermesh-apiserver` into the same namespace where Cilium is
   running:

        kubectl -n kube-system create -f install/

## Connect Cilium

1. Extract the IP and port of the `clustermesh-apiserver` service (Adjust the
   example based on the service type you are using):

        IP=$(kubectl -n kube-system get svc clustermesh-apiserver -o json | jq -r '.spec.clusterIP')
        PORT=$(kubectl -n kube-system get svc clustermesh-apiserver -o json | jq -r '.spec.ports[0].port')

2. Generate the configuration file to access the remote cluster. The file name
   `remote` must refer to the name of the remote cluster:

        cat > remote << EOF
        endpoints:
        - http://${IP}:${PORT}
        EOF

   If you have enabled SSL transport security, also refer to the certificates
   and keys:

        cat > remote << EOF
        endpoints:
        - https://${IP}:${PORT}
        trusted-ca-file: '/var/lib/cilium/clustermesh/remote-ca.crt'
        key-file: '/var/lib/cilium/clustermesh/remote.key'
        cert-file: '/var/lib/cilium/clustermesh/remote.crt'
        EOF

3. Create a Kubernetes secret in the same namespace as Cilium is running in to
   package the comfiguration file. If you are connecting to multiple clusters,
   repeat `--from-file` for each cluster. if you have referred to certificates
   and keys in the previous step, include these files as well:

        kubectl -n kube-system create secret generic cilium-clustermesh --from-file=remote -o yaml > clustermesh-secret.yaml

## Running in Mock mode

1. Modify `test/mock.json` as neeeded

2. Add the following to the `Dockerfile` to the final stage:

        ADD test/mock.json /mock.json

3. Add the following to the `args:` in `install/deployment.yaml`:

        - --mock-file=/mock.json

4. Build & deploy

## Troubleshooting

```
kubectl exec -ti clustermesh-apiserver -c etcd -- etcdctl get --prefix=true cilium/
```
