# Where should we write the GIF?
Output ./vhs-tapes/install-trustee.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Finally, we need an attestation server and a key broker service for secrets..."
Sleep 1
Ctrl+U
Type "Our solution will be Trustee..."
Sleep 1
Ctrl+U
Type "In this example everything is colocated on the same cluster, but that doesn't have to be the case..."
Sleep 1
Ctrl+U
Type "You can use Trustee to attest remote containers, servers, gpus, etc..."
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
Down
Sleep 1
Down
Sleep 1
Enter
Wait+Screen@120s /Full Send!/
Sleep 2