# Where should we write the GIF?
Output ./vhs-tapes/demo-02.gif

# Set up a 1200x1200 terminal with 46px font.
Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 1200

Type "Now that we can run workloads on our secured runtimes, let's try applying policy."
Sleep 1
Ctrl+U

Type "This is shown with Demo 02: 'Test Runtime With Policy'"
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
Enter

Wait+Screen@120s /Full Send!/
Sleep 2
Escape

Sleep 2
Type "clear"
Sleep 2
Enter

Type "Demo 02 updates the previous workload's policy to prevent execution."
Sleep 2
Ctrl+U

Sleep 2
Type "When we try to execute in the workload, we are prevented."
Sleep 2
Ctrl+U

Type "kubectl exec -it -n default coco-demo-02 -- bash"
Sleep 2
Enter
Enter

Type "Notice 'ExecProcessRequest is blocked by policy'"
Sleep 2
Ctrl+U

Type "To accomplish this, we added a policy to this workload under annotations"
Sleep 2
Ctrl+U

Type "cat demo-pods/coco-demo-02.yaml | grep --color=auto -B 2 io.katacontainers.config.agent.policy | cut -c 1-80"
Sleep 2
Enter

Type "We can see that policy by decoding the annotation's full value"
Sleep 2
Ctrl+U

Type "cat demo-pods/coco-demo-02.yaml | grep -B 2 io.katacontainers.config.agent.policy | yq .annotations.io*katacontainers*config*agent*policy | base64 -d"
Sleep 2
Enter

Type "Notice: 'default ExecProcessRequest := false'"
Sleep 2
Ctrl+U

Type "Try modifying the policy and seeing the results."
Sleep 2