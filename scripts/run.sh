# kind
kind create cluster --name minerva

# networking
kubectl apply -f gateway/gateway-api.yaml

# minerva
kubectl apply -f minerva/minerva-namespace.yaml
kubectl apply -f minerva/minerva-deployment.yaml
kubectl apply -f minerva/minerva-service.yaml
kubectl apply -f minerva/minerva-httproute.yaml
