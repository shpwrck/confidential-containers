# Where should we write the GIF?
Output ./vhs-tapes/demo-03.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "We introduce Trustee with Demo 03: Test Trustee Connection."
Sleep 1
Ctrl+U

Type "This demo proves that we are successfully connecting to the Trustee instance."
Sleep 1
Ctrl+U

Type './start-demo'
Sleep 1
Enter

Wait+Screen@30s /Full Send!/
Sleep 2
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Enter

Wait+Screen@120s /Full Send!/
Sleep 2
Escape

Sleep 2
Type "clear"
Sleep 2
Enter

Type "The new workload has an updated command that calls the internal confidential data hub."
Sleep 2
Ctrl+U

Type "If enabled, the confidential containers can access a proxy for several services locally on port 8006"
Sleep 2
Ctrl+U

Type "kubectl get pod coco-demo-03 -n default -o yaml | yq '.spec.containers[].command'"
Sleep 2
Enter

Type "kubectl get pod coco-demo-03 -n default -o yaml | yq .metadata.annotations.io*katacontainers*config*hypervisor*kernel_params | grep --color=auto 'http.*'"
Sleep 2
Enter

Type "We have loaded the node's ip and the trustee service's port into the kernel parameters of the confidential container."
Sleep 2
Ctrl+U

Type "clear"
Sleep 2
Enter

Type "We know that everything is successful by checking the logs of either Coco Demo 03 or Trustee"
Sleep 2
Ctrl+U

Type "kubectl logs coco-demo-03 -n default "
Sleep 2
Enter

Type "clear"
Sleep 2
Enter

Type "kubectl logs deployment/trustee-deployment -n trustee-system | tail -n 5"
Sleep 2
Enter

Sleep 4