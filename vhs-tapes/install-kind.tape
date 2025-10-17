# Where should we write the GIF?
Output ./vhs-tapes/install-kind.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "We are going to install the necessary components to run a confidential workload..."
Sleep 1
Ctrl+U
Type "First we need a kubernetes cluster..."
Sleep 1
Ctrl+U
Type "We will be using KinD or 'Kubernetes in Docker'..."
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
Enter
Wait+Screen@120s /Full Send!/
Sleep 2