# Where should we write the GIF?
Output ./vhs-tapes/demo-04.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "In Demo 04: Test Trustee Secret, we use trustee to store secret data."
Sleep 1
Ctrl+U

Type "We've loaded a secret into trustee using the 'kbs-client' and we are retrieving it in our workload."
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
Enter

Wait+Screen@120s /Full Send!/
Sleep 2
Escape

Sleep 2
Type "clear"
Sleep 2
Enter

Type "In Demo 03 we proved that our connection is correct, but for some reason our logs indicate failure"
Sleep 2
Ctrl+U

Type "kubectl logs coco-demo-04 -n default | grep --color=auto 'server returned error.*'"
Sleep 2
Enter

Type "Let's check the trustee logs and see if something is amiss there"
Sleep 2
Ctrl+U

Type "kubectl logs deployment/trustee-deployment -n trustee-system | grep --color=auto 'GET /kbs/v0/resource/default/secret/1'"
Sleep 2
Enter

Type "We can see the request is getting through, but it is being rejected (401) due to permissions."
Sleep 2
Ctrl+U

Type "We will fix this in the next demo."
Sleep 2
Ctrl+U
