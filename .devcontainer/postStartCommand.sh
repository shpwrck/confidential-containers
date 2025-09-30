#!/bin/bash

# Install kbs-client
oras pull ghcr.io/confidential-containers/staged-images/kbs-client:sample_only-c06de35b2e2ff7a26fd42d5374ecbdbee5168532-x86_64
sudo mv kbs-client /usr/local/bin/kbs-client
sudo chmod +x /usr/local/bin/kbs-client

# Install Guest Components
sudo apt install clang -y
git clone https://github.com/confidential-containers/guest-components.git
cd guest-components
cargo install --path  /workspaces/confidential-containers/guest-components/confidential-data-hub/hub/ --root /home/vscode/.local/