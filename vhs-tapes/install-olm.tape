# Where should we write the GIF?
Output ./vhs-tapes/install-olm.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Now that we have a cluster we can install the Operator Lifecycle Manager..."
Sleep 1
Ctrl+U
Type "The Operator Lifecycle Manager will make managing CoCo and Trustee much easier..."
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
Enter
Wait+Screen@120s /Full Send!/
Sleep 2