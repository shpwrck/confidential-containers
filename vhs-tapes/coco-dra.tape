# Where should we write the GIF?
Output ./vhs-tapes/coco-dra.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Please install the necessary components before proceeding: kinD, OLM, Confidential Containers Runtime Operator, and Confidential Container Runtimes"
Sleep 2
Ctrl+U
Type "Create the Namespace dra-tutorial"
Sleep 1
Type 'kubectl create namespace coco-dra'
Enter
Sleep 2
Ctrl+U
Type "Create the DeviceClass that represents the supported devices of the DRA driver"
Sleep 1
Type 'kubectl apply --server-side -f ./dra-config/deviceclass.yaml`
Sleep 1
Enter
Sleep 2
Type "Create the RBAC resources used by the DRA driver to interact with the Kubernetes API"
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f /workspaces/confidential-containers/dra-config/serviceaccount.yaml'
Enter
Sleep 2
Type 'kubectl apply --server-side -f ./dra-config/clusterrole.yaml 
Sleep 1
Enter
Sleep 2
Type 'kubectl apply --server-side -f ./dra-config/crb.yaml'
Sleep 1
Enter 
Sleep 2
Ctrl+U
Type "Create the PriorityClass to prevent preemption of the DRA driver" 
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f ./dra-config/priorityclass.yaml'
Sleep 1
Enter
Sleep 2
Ctrl+U
Type "Before creating the DRA driver, let's take a look at the DRA driver's manifest"
Sleep 1
Ctrl+U
Type 'head -n 27 ./dra-config/dra-driver-daemonset.yaml`
Enter
Ctrl+U
Type "Create the DRA driver in a DaemonSet, the driver binary is in a container image"
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f ./dra-config/dra-driver-daemonset.yaml'
Enter
Sleep 3
Ctrl+U
Type "Verify the DRA is installed"
Sleep 1
Ctrl+U
Type 'kubectl get pod -l app.kubernetes.io/name=dra-example-driver -n dra-tutoral'
Enter
Sleep 4
Wait+Screen /Running/
Sleep 2
Ctrl+U
Type "The DRA driver updates the local node on which devices are available through a ResourceSlice"
Type "Let's look at the ResourceSlice"
Sleep 1
Ctrl+U
Type 'kubectl get resourceslice'
Enter
Sleep 2
Type "Create a ResourceClaim to claim the DeviceClass"
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f ./dra-config/resourceclaim.yaml'
Enter
Sleep 2
Type "The components to use DRA are now created"
Sleep 1
Ctrl+U
Type "Create a Confidential Container Pod that references the ResourceClaim that references the DeviceClass to use the DRA driver"
Sleep 2
Ctrl+U
Type "Let's take a look at the Pod's manifest first"
Sleep 1
Ctrl+U
Type 'head -n 11 ./dra-config/coco-dra-pod.yaml'
Enter
Sleep 1
Type "In the Pod manifest we see the Pod using the kata-qemu-coco-dev runtime"
Sleep 2
Ctrl+U
Type 'tail -n 6 ./dra-config/coco-dra-pod.yaml'
Enter
Sleep 2
Type "The Pod references the ResourceClaim previously created"
Sleep 2
Ctrl+U
Type "Create the Pod"
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f ./dra-config/coco-dra-pod.yaml"
Enter
Sleep 5
Ctrl+U

Check the Pod logs to report the name of the example GPU kubectl logs coco-dra-pod -n coco-dra | grep -E "GPU_DEVICE_[0-9]+=" | grep -v "RESOURCE_CLAIM"


