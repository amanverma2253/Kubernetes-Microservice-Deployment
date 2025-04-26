#!/bin/bash

# Build and push Docker images
cd docker/service1
docker build -t yourdockerhub/service1:latest .
docker push yourdockerhub/service1:latest

cd ../service2
docker build -t yourdockerhub/service2:latest .
docker push yourdockerhub/service2:latest

cd ../service3
docker build -t yourdockerhub/service3:latest .
docker push yourdockerhub/service3:latest

cd ../../kubernetes

# Apply deployments
kubectl apply -f deployments/service1-deployment.yaml
kubectl apply -f deployments/service2-deployment.yaml
kubectl apply -f deployments/service3-deployment.yaml

# Apply services
kubectl apply -f services/service1-service.yaml
kubectl apply -f services/service2-service.yaml
kubectl apply -f services/service3-service.yaml

# Wait for pods to be ready
kubectl wait --for=condition=Ready pods --all --timeout=300s

# Get service URLs
echo "Service3 is exposed on NodePort. Access it using:"
minikube service service3 --url

echo "Kubernetes Dashboard can be accessed using:"
kubectl proxy &
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"