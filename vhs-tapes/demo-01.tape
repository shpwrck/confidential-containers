# Where should we write the GIF?
Output ./vhs-tapes/demo-01.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Let's explore our environment now that we have everything installed!"
Sleep 1
Ctrl+U
Type "We will run Demo 01: 'Test Runtime'"
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
Enter
Wait+Screen@120s /Full Send!/
Sleep 2
Type "q"
Sleep 1
Type "clear"
Sleep 2
Enter
Type "Demo 01 is a basic functionality test"
Sleep 2
Ctrl+U
Sleep 2
Type "We can see that it worked by running the following command..."
Sleep 1s
Ctrl+U
Type "kubectl get pods -n default coco-demo-01"
Sleep 2
Enter
Type "We can see that it is in the running state"
Sleep 2
Ctrl+U
Type "If we look deeper we can see that it's running as a qemu-container"
Ctrl+U
Sleep 2
Type "kubectl get pods -n default coco-demo-01 -o yaml | grep --color=auto 'runtimeClassName'"
Sleep 2
Enter
Type "Instead of the basic container runtime, we see that we are using 'kata-qemu-coco-dev'"
Sleep 2
Ctrl+U
Sleep 2

