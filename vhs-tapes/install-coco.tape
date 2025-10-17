# Where should we write the GIF?
Output ./vhs-tapes/install-coco.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Now that all of our dependencies have been installed we can install the Confidential Containers Runtime Operator and start setting up our Confidential Runtimes..."
Sleep 1
Ctrl+U
Type "The Confidential Runtime deploys 3 daemonsets that manage the containerd runtime configuration..."
Sleep 1
Ctrl+U
Type "Once the 'PreInstall' and `Install` daemonsets have finished configuring and restarting containerd, several additional runtimes will be available."
Sleep 1
Ctrl+U
Type './start-demo'
Sleep 1
Enter
Wait+Screen@30s /Full Send!/
Sleep 2
Down
Sleep 1
Down
Sleep 1
Down
Sleep 1
Down
Sleep 1
Enter
Wait+Screen@120s /Full Send!/
Sleep 2
Down
Sleep 1
Down
Sleep 1
Down
Sleep 1
Down
Sleep 1
Down
Sleep 1
Enter
Wait+Screen@120s /Full Send!/
Sleep 2