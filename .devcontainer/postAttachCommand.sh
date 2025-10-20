#!/bin/bash

quiet_exec() {
	"$@" >/dev/null 2>&1
	return $?
}

print_banner() {
	gum style --align center --border double --margin "1" --padding "1 2" --border-foreground "2" \
		"Welcome to the $(gum style --foreground 3 'Confidential Containers Demo')." \
		"What would you like to do?"
}

validate_command() {
	local STATUS=$1
	if [ $STATUS -eq 0 ]; then
		echo ':white_check_mark:' | gum format -t emoji
		return 0
	else
		echo ':x:' | gum format -t emoji
		return 1
	fi
}

kind_cluster_installed() {
	kind get clusters -q | grep -q coco-test
	validate_command $?
}

install_kind() {
	echo "Installing Kind Cluster..."
	gum spin --title "(1/1) Creating Kind Cluster" -- \
		bash -c "kind create cluster --config ./cluster-config/kind-config.yaml"
	gum format -t emoji ":white_check_mark: Kind Cluster Created!"
	quiet_exec docker exec -it coco-test-control-plane bash -c "ctr -n k8s.io content fetch docker.io/library/busybox:stable-uclibc"
	sleep 2
}

destroy_kind() {
	echo "Destroying Kind Cluster..."
	gum spin --title "(1/1) Destroying Kind Cluster" -- \
		bash -c "kind delete cluster --name coco-test"
	gum format -t emoji ":white_check_mark: Kind Cluster Destroyed!"
	sleep 2
}

olm_installed() {
	quiet_exec kubectl cluster-info && \
	quiet_exec kubectl get -f ./cluster-config/crds.yaml && \
	quiet_exec kubectl get -f ./cluster-config/olm.yaml
	validate_command $?
}

install_olm() {
	echo "Installing Operator Lifecycle Manager..."
	gum spin --title "(1/3) Installing Operator Lifecycle Manager CRDs" -- \
		bash -c "kubectl apply -f ./cluster-config/crds.yaml --wait && sleep 5"
	gum format -t emoji ":white_check_mark: Operator Lifecycle Manager CRDs Installed!"
	gum spin --title "(2/3) Installing Operator Lifecycle Manager" -- \
		bash -c "kubectl apply -f ./cluster-config/olm.yaml --wait && sleep 5"
	gum format -t emoji ":white_check_mark: Operator Lifecycle Manager Deployed!"
	gum spin --title "(3/3) Waiting for OLM to be ready..." -- \
		bash -c "kubectl wait --for=condition=Available --timeout=120s deployment/olm-operator -n olm && \
			kubectl wait --for=condition=Available --timeout=120s deployment/catalog-operator -n olm && \
			kubectl wait --for=condition=Available --timeout=120s deployment/packageserver -n olm"
	gum format -t emoji ":white_check_mark: Operator Lifecycle Manager Ready!"
	sleep 2
}

coco_installed() {
	quiet_exec kubectl get deployment cc-operator-controller-manager -n confidential-containers-system
	validate_command $?
}

install_coco_operator() {
	echo "Installing Confidential Containers Operator..."
	gum spin --title "(1/5) Installing Confidential Containers Operator" -- \
		bash -c "kubectl apply -f ./coco-config/coco-operator.yaml --wait"
	gum format -t emoji ":white_check_mark: Confidential Containers Operator Deployment Created!"
	gum spin --title "(2/5) Waiting for install plan to be created..." -- \
		bash -c 'kubectl wait --for=create installplan -n confidential-containers-system  -l operators.coreos.com/cc-operator.confidential-containers-system="" --timeout=600s'
	gum format -t emoji ":white_check_mark: Install Plan Created!"
	gum spin --title "(3/5) Approving install plan..." -- \
		bash -c "kubectl patch $(kubectl get installplans.operators.coreos.com -n confidential-containers-system -o name) -n confidential-containers-system --type='json' -p '[{\"op\":\"replace\",\"path\":\"/spec/approved\",\"value\":true}]'"
	gum format -t emoji ":white_check_mark: Install Plan Approved!"
	while ! quiet_exec kubectl get deployment cc-operator-controller-manager -n confidential-containers-system; do
		gum spin --title "(4/5) Waiting for coco-operator deployment to be created..." -- sleep 5
	done
	gum format -t emoji ":white_check_mark: Confidential Containers Operator Deployment Found!"
	gum spin --title "(5/5) Waiting for coco-operator to be ready..." -- \
		bash -c "kubectl wait --for=condition=Available --timeout=120s deployment/cc-operator-controller-manager -n confidential-containers-system"
	gum format -t emoji ":white_check_mark: Confidential Containers Operator Ready!"
	sleep 2
}

ccr_installed() {
	quiet_exec kubectl get ccr ccruntime-sample && \
	quiet_exec kubectl get runtimeclass kata-qemu-coco-dev
	validate_command $?
}

install_ccr() {
	echo "Installing Confidential Containers Runtime..."
	gum spin --title "(1/2) Installing Confidential Containers Runtime" -- \
		bash -c "kubectl apply -f ./coco-config/ccruntime-sample.yaml --wait"
	gum format -t emoji ":white_check_mark: Confidential Containers Runtime Created!"
	while ! quiet_exec kubectl get runtimeclass kata-qemu-coco-dev; do
		gum spin --title "(2/2) Waiting for kata-qemu-coco-dev runtimeclass to be created..." -- sleep 5
	done
	gum format -t emoji ":white_check_mark: Confidential Containers Runtime Ready!"
	sleep 2
}

coco_demo_01() {
	quiet_exec kubectl get pod coco-demo-01 -n default
	validate_command $?
}

trustee_operator_installed() {
	quiet_exec kubectl get deployment trustee-operator-controller-manager -n trustee-system
	validate_command $?
}

install_trustee_operator() {
	echo "Installing Trustee Operator..."
	gum spin --title "(1/5) Installing Trustee Operator" -- \
		bash -c "kubectl apply -f ./trustee-config/trustee-operator.yaml --wait"
	gum format -t emoji ":white_check_mark: Trustee Operator Created!"
	gum spin --title "(2/5) Waiting for install plan to be created..." -- \
		bash -c 'kubectl wait --for=create installplan -n trustee-system  -l operators.coreos.com/trustee-operator.trustee-system="" && sleep 5'
	gum format -t emoji ":white_check_mark: Install Plan Created!"
	gum spin --title "(3/5) Approving install plan..." -- \
		bash -c "kubectl patch $(kubectl get installplans.operators.coreos.com -n trustee-system -o name) -n trustee-system --type='json' -p '[{\"op\":\"replace\",\"path\":\"/spec/approved\",\"value\":true}]'"
	gum format -t emoji ":white_check_mark: Install Plan Approved!"	
	while ! quiet_exec kubectl get deployment trustee-operator-controller-manager -n trustee-system; do
		gum spin --title "(4/5) Waiting for trustee-operator deployment to be created..." -- sleep 5
	done
	gum format -t emoji ":white_check_mark: Trustee Operator Deployment Found!"
	gum spin --title "(5/5) Waiting for trustee-operator to be ready..." -- \
		bash -c "kubectl wait --for=condition=Available --timeout=120s deployment/trustee-operator-controller-manager -n trustee-system"
	gum format -t emoji ":white_check_mark: Trustee Operator Ready!"
	sleep 2
}

trustee_instance_installed() {
	quiet_exec kubectl get deployment trustee-deployment -n trustee-system
	validate_command $?
}

install_trustee_instance() {
	echo "Installing Trustee Instance..."
	openssl genpkey -algorithm ed25519 -out /tmp/kbs.pem
	export SECRET_KEY=$(cat /tmp/kbs.pem | base64 -w0)
	gum spin --title "(1/5) Installing Secret Key" -- \
		bash -c "envsubst < ./trustee-config/secret_key.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Secret Key Installed!"
	gum spin --title "(2/5) Installing KBS ConfigMap" -- \
		bash -c "kubectl apply -f ./trustee-config/kbs-configmap.yaml"
	gum format -t emoji ":white_check_mark: KBS ConfigMap Installed!"
	gum spin --title "(3/5) Installing RVPS Reference Values ConfigMap" -- \
		bash -c "kubectl apply -f ./trustee-config/rvps-reference-values-configmap.yaml"
	gum format -t emoji ":white_check_mark: RVPS Reference Values ConfigMap Installed!"
	gum spin --title "(4/5) Installing KBSConfig Sample" -- \
		bash -c "kubectl apply -f ./trustee-config/kbsconfig-sample.yaml"
	gum format -t emoji ":white_check_mark: KBSConfig Sample Installed!"
	while ! quiet_exec kubectl get deployment trustee-deployment -n trustee-system; do
		gum spin --title "(5/5) Waiting for trustee-operator deployment to be created..." -- sleep 2
	done
	gum format -t emoji ":white_check_mark: Trustee Instance Deployment Found!"
	gum spin --title "Waiting for Trustee Instance to be ready..." -- \
		bash -c "kubectl wait --for=condition=Available --timeout=120s deployment/trustee-operator-controller-manager -n trustee-system"
	gum format -t emoji ":white_check_mark: Trustee Instance Ready!"
	sleep 2
}

install_coco_demo_01() {
	echo "Installing CoCo Demo 01..."
	gum spin --title "(1/2) Installing CoCo Demo 01" -- \
		bash -c "kubectl apply -f ./demo-pods/coco-demo-01.yaml"
	gum format -t emoji ":white_check_mark: Demo 01 Deployment Created!"
	gum spin --title "(2/2) Waiting for CoCo Demo 01 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-01 -n default"
	gum format -t emoji ":white_check_mark: Demo 01 Ready!"
	sleep 2
}

coco_demo_02() {
	quiet_exec kubectl get pod coco-demo-02 -n default
	validate_command $?
}

install_coco_demo_02() {
	echo "Installing CoCo Demo 02..."
	gum spin --title "(1/2) Installing CoCo Demo 02" -- \
		bash -c "kubectl apply -f ./demo-pods/coco-demo-02.yaml"
	gum format -t emoji ":white_check_mark: Demo 02 Deployment Created!"
	gum spin --title "(2/2) Waiting for CoCo Demo 02 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-02 -n default"
	gum format -t emoji ":white_check_mark: Demo 02 Ready!"
	sleep 2
}

coco_demo_03() {
	quiet_exec kubectl get pod coco-demo-03 -n default
	validate_command $?
}

install_coco_demo_03() {
	export KBS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' -n trustee-system)
	export KBS_PORT=$(kubectl get svc kbs-service -o jsonpath='{.spec.ports[0].nodePort}' -n trustee-system)
	echo "Installing CoCo Demo 03..."
	gum spin --title "(1/2) Installing CoCo Demo 03" -- \
		bash -c "envsubst < ./demo-pods/coco-demo-03.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Demo 03 Deployment Created!"
	gum spin --title "(2/2) Waiting for CoCo Demo 03 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-03 -n default"
	gum format -t emoji ":white_check_mark: Demo 03 Ready!"
	sleep 2
}

coco_demo_04() {
	quiet_exec kubectl get pod coco-demo-04 -n default
	validate_command $?
}

install_coco_demo_04() {
	while ! quiet_exec command -v kbs-client; do
		gum spin --title "(*/0) Waiting for kbs-client to be installed..." -- sleep 5
	done
	export KBS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' -n trustee-system)
	export KBS_PORT=$(kubectl get svc kbs-service -o jsonpath='{.spec.ports[0].nodePort}' -n trustee-system)
	export KBS_PRIVATE_KEY="/tmp/kbs.pem"
	echo "Installing CoCo Demo 04..."
	gum spin --title "(1/3) Loading Secret into KBS" -- \
		bash -c "kbs-client --url "http://$KBS_HOST:$KBS_PORT" config --auth-private-key "$KBS_PRIVATE_KEY" set-resource --path default/secret/1 --resource-file ./demo-pods/secret.txt"
	gum format -t emoji ":white_check_mark: Secret Loaded into KBS!"
	gum spin --title "(2/3) Installing CoCo Demo 04" -- \
		bash -c "envsubst < ./demo-pods/coco-demo-04.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Demo 04 Deployment Created!"
	gum spin --title "(3/3) Waiting for CoCo Demo 04 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-04 -n default"
	gum format -t emoji ":white_check_mark: Demo 04 Ready!"
	sleep 2
}

coco_demo_05() {
	quiet_exec kubectl get pod coco-demo-05 -n default
	validate_command $?
}

install_coco_demo_05() {
	while ! quiet_exec command -v kbs-client; do
		gum spin --title "(*/0) Waiting for kbs-client to be installed..." -- sleep 5
	done
	export KBS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' -n trustee-system)
	export KBS_PORT=$(kubectl get svc kbs-service -o jsonpath='{.spec.ports[0].nodePort}' -n trustee-system)
	export KBS_PRIVATE_KEY="/tmp/kbs.pem"
	echo "Installing CoCo Demo 05..."
	gum spin --title "(1/3) Load Policy into KBS" -- \
		bash -c "kbs-client --url "http://$KBS_HOST:$KBS_PORT" config --auth-private-key "$KBS_PRIVATE_KEY" set-resource-policy --policy-file ./trustee-config/resources_policy.rego"
	gum format -t emoji ":white_check_mark: Policy Loaded into KBS!"
	gum spin --title "(2/3) Installing CoCo Demo 05" -- \
		bash -c "envsubst < ./demo-pods/coco-demo-05.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Demo 05 Deployment Created!"
	gum spin --title "(3/3) Waiting for CoCo Demo 05 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-05 -n default"
	gum format -t emoji ":white_check_mark: Demo 05 Ready!"
	sleep 2
}

coco_demo_06() {
	quiet_exec kubectl get pod coco-demo-06 -n default
	validate_command $?
}	

install_coco_demo_06() {
	while ! quiet_exec command -v kbs-client; do
		gum spin --title "(*/0) Waiting for kbs-client to be installed..." -- sleep 5
	done
	while ! quiet_exec command -v secret; do
		gum spin --title "(*/0) Waiting for secret-client to be installed..." -- sleep 5
	done
	echo "Installing CoCo Demo 06..."
	export KBS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' -n trustee-system)
	export KBS_PORT=$(kubectl get svc kbs-service -o jsonpath='{.spec.ports[0].nodePort}' -n trustee-system)
	export KBS_PRIVATE_KEY="/tmp/kbs.pem"
	gum spin --title "(1/4) Apply Looser Policy to KBS" -- \
		bash -c "kbs-client --url "http://$KBS_HOST:$KBS_PORT" config --auth-private-key ./auth.key set-resource-policy --policy-file ./trustee-config/allow_all.rego"
	gum format -t emoji ":white_check_mark: Policy Applied to KBS!"
	export SECRET_REF=$(secret seal vault --resource-uri kbs:///default/secret/1 --provider kbs | tail -1)
	gum spin --title "(2/4) Creating Kubernetes Secret (Pointer)..." -- \
		bash -c "envsubst < ./demo-pods/sealed-secret.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Secret (Pointer) Created!"
	gum spin --title "(3/4) Installing CoCo Demo 06" -- \
		bash -c "envsubst < ./demo-pods/coco-demo-06.yaml | kubectl apply -f -"
	gum format -t emoji ":white_check_mark: Demo 06 Deployment Created!"
	gum spin --title "(4/4) Waiting for CoCo Demo 06 to be running..." --timeout 60s -- \
		bash -c "kubectl wait --for=condition=Ready --timeout=120s pod/coco-demo-06 -n default"
	gum format -t emoji ":white_check_mark: Demo 06 Ready!"
	sleep 2
}

show_menu() {

	ACTION=$(gum table --border rounded --height "15" -s ',' <<- EOF
		Step,Status
		Full Send!,$(echo ':rocket:' | gum format -t emoji)
		------------------------------------------,--
		Install Kind,$( kind_cluster_installed )
		Install Operator Lifecycle Manager,$( olm_installed )
		Install Confidential Containers Operator,$( coco_installed )
		Install Confidential Container Runtime,$( ccr_installed )
		Install Trustee Operator,$( trustee_operator_installed )
		Install Trustee Instance,$( trustee_instance_installed )
		Test Runtime,$( coco_demo_01 )
		Test Runtime With Policy,$( coco_demo_02 )
		Test Trustee Connection,$( coco_demo_03 )
		Test Trustee Secret,$( coco_demo_04 )
		Test Trustee Secret Policy,$( coco_demo_05 )
		Test Sealed Secrets,$( coco_demo_06 )
		----------------------------,--
		Run K9S,$(echo ':dog:' | gum format -t emoji)
		Clean Up Cluster,$(echo ':wastebasket:' | gum format -t emoji)
		Finish,$(echo ':checkered_flag:' | gum format -t emoji)
		EOF
	)
	echo $(echo $ACTION | cut -d ',' -f 1)
}

main() {

	clear

	gum style --align center --border double --margin "1" --padding "1 2" --border-foreground "2" \
		"Welcome to the $(gum style --foreground 3 'Confidential Containers Demo')." \
		"What would you like to do?"
	
	while true; do
		option=$(show_menu)
		case $option in
			Full\ Send!)
				destroy_kind
				install_kind
				install_olm
				install_coco_operator
				install_ccr
				install_trustee_operator
				install_trustee_instance
				install_coco_demo_01
				install_coco_demo_02
				install_coco_demo_03
				install_coco_demo_04
				install_coco_demo_05
				install_coco_demo_06
				clear
				print_banner
				;;
			Install\ Kind)
				if quiet_exec kind_cluster_installed; then
					gum spin --title "Kind cluster is already installed." -- sleep 2
				else
					install_kind
					clear
					print_banner
				fi
				;;
			Install\ Operator\ Lifecycle\ Manager)
				if quiet_exec olm_installed; then
					gum spin --title "Operator Lifecycle Manager is already installed." -- sleep 2
				else
					install_olm
					clear
					print_banner
				fi
				;;
			Install\ Confidential\ Containers\ Operator)
				if quiet_exec coco_installed; then
					gum spin --title "Confidential Containers Operator is already installed." -- sleep 2
				else
					install_coco_operator
					clear
					print_banner
				fi
				;;
			Install\ Confidential\ Container\ Runtime)
				if quiet_exec ccr_installed; then
					gum spin --title "Confidential Containers Runtime is already installed." -- sleep 2
				else
					install_ccr
					clear
					print_banner
				fi
				;;
			Install\ Trustee\ Operator)
				if quiet_exec trustee_operator_installed; then
					gum spin --title "Trustee Operator is already installed." -- sleep 2
				else
					install_trustee_operator
					clear
					print_banner
				fi
				;;
			Install\ Trustee\ Instance)
				if quiet_exec trustee_instance_installed; then
					gum spin --title "Trustee Instance is already installed." -- sleep 2
				else
					install_trustee_instance
					clear
					print_banner
				fi
				;;
			Test\ Runtime)
				if quiet_exec coco_demo_01; then
					gum spin --title "Demo 01 is already installed." -- sleep 2
				else
					install_coco_demo_01
					clear
					print_banner
				fi
				;;
			Test\ Runtime\ With\ Policy)
				if quiet_exec coco_demo_02; then
					gum spin --title "Demo 02 is already installed." -- sleep 2
				else
					install_coco_demo_02
					clear
					print_banner
				fi
				;;
			Test\ Trustee\ Connection)
				if quiet_exec coco_demo_03; then
					gum spin --title "Demo 03 is already installed." -- sleep 2
				else
					install_coco_demo_03
					clear
					print_banner
				fi
				;;
			Test\ Trustee\ Secret)
				if quiet_exec coco_demo_04; then
					gum spin --title "Demo 04 is already installed." -- sleep 2
				else
					install_coco_demo_04
					clear
					print_banner
				fi
				;;
			Test\ Trustee\ Secret\ Policy)
				if quiet_exec coco_demo_05; then
					gum spin --title "Demo 05 is already installed." -- sleep 2
				else
					install_coco_demo_05
					clear
					print_banner
				fi
				;;
			Test\ Sealed\ Secrets)
				if quiet_exec sealed_secrets; then
					gum spin --title "Demo 06 is already installed." -- sleep 2
				else
					install_coco_demo_06
					clear
					print_banner
				fi
				;;
			Run\ K9S)
				k9s
				clear
				print_banner
				;;
			Clean\ Up\ Cluster)
				if ! quiet_exec kind_cluster_installed; then
					gum spin --title "No Kind cluster found to clean up." -- sleep 2
				else
					destroy_kind
					clear
					print_banner
				fi
				;;
			*)
				clear
				gum style --border double --margin "1" --padding "1 2" --border-foreground "2" \
					"Thank you for using the " \
					"$(gum style --foreground 3 'Confidential Containers Demo')."
				break
				;;
		esac
	done
}

main