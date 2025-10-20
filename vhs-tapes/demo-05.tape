# Where should we write the GIF?
Output ./vhs-tapes/demo-05.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "In Demo 05: Test Trustee Secret Policy, we add a policy that allows access to our kbs secret"
Sleep 1
Ctrl+U

Type "Once again, loading the policy has been done for us already."
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
Enter

Wait+Screen@120s /Full Send!/
Sleep 2
Escape

Sleep 2
Type "clear"
Sleep 2
Enter

Type "This time our logs should show our secret value."
Sleep 2
Ctrl+U

Type "kubectl logs coco-demo-05 -n default | grep --color=auto 'Super Secret Value'"
Sleep 2
Enter

Type "Success!"
Sleep 2
Ctrl+U

Type "By applying policy, we can control what systems have access to our secret."
Sleep 2
Ctrl+U

Type "In our case (without confidential hardware) we are simply allowing the sample measurements."
Sleep 2
Ctrl+U

Type "cat trustee-config/resources_policy.rego"
Sleep 2
Enter

Type "There are plenty of ways to authorize/reject requests. Try enabling Debug messaging in Trustee to see what data can be acted upon."
Sleep 2
Ctrl+U