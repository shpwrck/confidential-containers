# Where should we write the GIF?
Output ./vhs-tapes/demo-06.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "In this final demo, Demo 06: Test Sealed Secrets, we pull secrets from Trustee in a more traditional Kubernetes manner"
Sleep 1
Ctrl+U

Type "Instead of encoding secrets in annotations, we can use Kubernetes secrets."
Sleep 1
Ctrl+U

Type "But we do not want to use Kubernetes secrets directly. They are not in our Trusted Compute Boundary."
Sleep 1
Ctrl+U

Type "Instead we will store a pointer in the Kubernetes secret that will be referenced, to pull our kbs-secret by address."
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

Type "Our secret is once again available to our workload."
Sleep 2
Ctrl+U

Type "kubectl logs coco-demo-06 -n default | grep --color=auto 'Super Secret Value'"
Sleep 2
Enter

Type "And we can confirm that our secret is not stored in Kubernetes"
Sleep 2
Ctrl+U

Type "kubectl get secrets/sealed-secret --template={{.data.secret}} | base64 -d | cut -d"." -f3 | base64 -d | jq"
Sleep 2
Enter

Type "We are using this data to load our kbs-secret into our workload dynamically."
Sleep 2
Ctrl+U