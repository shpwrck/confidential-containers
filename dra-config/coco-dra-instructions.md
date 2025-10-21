1. Create the `dra-tutorial` namespace
`kubectl create namespace dra-tutorial`

2. Create the DeviceClass that represents the supported devices of the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/deviceclass.yaml`

3. Create the RBAC resources used by the DRA driver to interact with the Kubernetes API
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/serviceaccount.yaml`
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/clusterrole.yaml`
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/crb.yaml`

4. Create the PriorityClass to prevent preemption of the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/priorityclass.yaml`

5. Create the DRA driver in a Daemonset, the driver binary is in a container image
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/dra-driver-daemonset.yaml`

6. Verify the DRA driver running in a DaemonSet is running
`kubectl get pod -l app.kubernetes.io/name=dra-example-driver -n dra-tutorial`

7. The DRA driver updates the local node on which devices are available through a ResourceSlice
`kubectl get resourceslice`

8. Describe the ResourceSlice to see information of the devices on the node
`kubectl describe $(kubectl get resourceslice -o name)`

9. Create a ResourceClaim to claim the DeviceClass
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/resourceclaim.yaml`

10. Verify the ResourceClaim is created
`kubectl get resourceclaim -n dra-tutorial`

11. Create a Confidential Container Pod that references the ResourceClaim that references the DeviceClass to use the DRA driver
`kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/coco-dra-pod.yaml`

12. Check if the ResourceClaim is used
`kubectl get resourceclaim -n dra-tutorial`

