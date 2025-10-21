# Where should we write the GIF?
Output coco-dra.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Please install the required components before proceeding: kinD, OLM, Confidential Containers Runtime Operator, and Confidential Container Runtimes"
Sleep 2
Ctrl+U
Type "Create the Namespace dra-tutorial"
Sleep 1
Ctrl+U
Type "kubectl create namespace dra-tutorial"
Sleep 1
Enter
Sleep 2
Ctrl+U
Type "Create the DeviceClass that represents the supported devices of the DRA driver"
Sleep 1
Ctrl+U
Type "kubectl apply --server-side -f ../dra-config/deviceclass.yaml"
Sleep 1
Enter
Type "clear"
Sleep 1
Enter
Type "Create the RBAC resources used by the DRA driver to interact with the Kubernetes API"
Sleep 1
Ctrl+U
Type "kubectl apply --server-side -f ../dra-config/serviceaccount.yaml"
Sleep 1
Enter
Sleep 2
Type "kubectl apply --server-side -f ../dra-config/clusterrole.yaml"
Sleep 1
Enter
Sleep 2
Type "kubectl apply --server-side -f ../dra-config/crb.yaml"
Sleep 1
Enter 
Sleep 2
Type "clear"
Sleep 1
Enter
Type "Create the PriorityClass to prevent preemption of the DRA driver" 
Sleep 1
Ctrl+U
Type "kubectl apply --server-side -f ../dra-config/priorityclass.yaml"
Sleep 1
Enter
Sleep 2
Type "clear"
Sleep 1
Enter
Type "Before creating the DRA driver, let's take a look at the DRA driver's manifest"
Sleep 1
Ctrl+U
Type "head -n 27 ../dra-config/dra-driver-daemonset.yaml"
Sleep 1
Enter
Sleep 5
Type "clear"
Sleep 1
Enter
Type "Create the DRA driver in a DaemonSet, the driver binary is in a container image"
Sleep 1
Ctrl+U
Type "kubectl apply --server-side -f ../dra-config/dra-driver-daemonset.yaml"
Sleep 1
Enter
Sleep 3
Type "clear"
Sleep 1
Enter
Type "Verify the DRA driver running in a DaemonSet is installed"
Sleep 1
Ctrl+U
Type "kubectl get pod -l app.kubernetes.io/name=dra-example-driver -n dra-tutorial"
Sleep 1
Enter
Sleep 1
Type "clear"
Sleep 1
Enter 
Type "The DRA driver updates the local node on which devices are available through a ResourceSlice"
Sleep 1
Ctrl+U
Type "Let's look at the ResourceSlice"
Sleep 1
Ctrl+U
Type "kubectl get resourceslice"
Sleep 1
Enter
Sleep 2
Type "Describe the ResourceSlice to see information of the devices on the node"
Sleep 1
Ctrl+U
Sleep 1
Enter
Type "kubectl describe $(kubectl get resourceslice -o name)"
Sleep 1
Enter
Sleep 5
Type "clear"
Sleep 1
Enter
Type "Create a ResourceClaim to claim the DeviceClass"
Sleep 1
Ctrl+U
Type "kubectl apply --server-side -f ../dra-config/resourceclaim.yaml"
Sleep 1
Enter
Sleep 2
Type "Verify the ResourceClaim is created"
Sleep 1
Ctrl+U
Type "kubectl get resourceclaim -n dra-tutorial"
Sleep 1
Enter
Sleep 2
Type "clear"
Sleep 1
Enter
Type "The components to use DRA are now created"
Sleep 1
Ctrl+U
Type "Create a Confidential Container Pod that references the ResourceClaim that references the DeviceClass to use the DRA driver"
Sleep 2
Ctrl+U
Type "Let's take a look at the Pod's manifest first"
Sleep 1
Ctrl+U
Type "head -n 11 ../dra-config/coco-dra-pod.yaml"
Sleep 1
Enter
Sleep 2
Type "clear"
Sleep 1
Enter
Type "In the Pod manifest we see the Pod uses the kata-qemu-coco-dev runtime"
Sleep 2
Ctrl+U
Type "tail -n 6 ../dra-config/coco-dra-pod.yaml"
Sleep 1
Enter
Sleep 2
Type "clear"
Enter
Type "The Pod references the ResourceClaim previously created"
Sleep 2
Ctrl+U
Type "Create the Pod"
Sleep 1
Ctrl+U
Type 'kubectl apply --server-side -f ../dra-config/coco-dra-pod.yaml'
Sleep 1
Enter
Sleep 10
Type "Check if the ResourceClaim is used"
Sleep 1
Ctrl+U
Type 'kubectl get resourceclaim -n dra-tutorial'
Sleep 1
Enter
Sleep 5
