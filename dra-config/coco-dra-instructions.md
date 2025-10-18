1. Create the `dra-tutorial` namespace
`kubectl create namespace dra-tutorial`

2. Create the DRA driver in a Daemonset, the driver binary is in a container image
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/dra-driver-daemonset.yaml`

3. Verify installation
`kubectl get pod -l app.kubernetes.io/name=dra-example-driver -n dra-tutorial`


4. Create the RBAC resources used by the DRA driver to interact with the Kubernetes API
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/serviceaccount.yaml`
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/clusterrole.yaml`
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/crb.yaml`

4. Create the PriorityClass to prevent preemption of the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/priorityclass.yaml`

6. Create the DeviceClass that represents the supported devices of the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/deviceclass.yaml`


7. The DRA driver updates the local node on which devices are available through a ResourceSlice
`kubectl get resourceslice`

8. Create a ResourceClaim to claim the DeviceClass
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/resourceclaim.yaml`

9. Create a CoCo Pod that references the ResourceClaim to use the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/coco-dra-pod.yaml`

10. Check the Pod logs to report the name of the example GPU
`kubectl logs coco-dra-pod -n dra-tutorial | grep -E "GPU_DEVICE_[0-9]+=" | grep -v "RESOURCE_CLAIM"`

Expected output:
```
declare -x GPU_DEVICE_0="gpu-0"
```

