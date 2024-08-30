CLUSTER_NAME="swagger-hub"

kind-cluster-create:
	kind create cluster --name ${CLUSTER_NAME} --config cluster/kind.config.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	kubectl delete validatingwebhookconfiguration ingress-nginx-admission

kind-cluster-delete:
	kind delete clusters ${CLUSTER_NAME}

kind-cluster-context:
	kubectl cluster-info --context kind-${CLUSTER_NAME}

app-deploy:
	kubectl apply -f app

app-debug:
	kubectl run -i --tty --rm debug --image=busybox --restart=Never