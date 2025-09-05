# Kubernetes Canary Deployment with K3s + Istio

## Project Overview
This project demonstrates a **Canary Deployment** strategy using **K3s Kubernetes** and **Istio Service Mesh**.  
It showcases **progressive traffic shifting** between two versions of an application (`v1` and `v2`), with rollback support and observability via **Kiali, Grafana, Prometheus, and Jaeger**.

Why this project is important:
- Canary deployments = safer application rollouts
- Istio = advanced traffic management + observability
- Great resume project to showcase **Kubernetes + Service Mesh + DevOps skills**

---

## Tech Stack
- [K3s](https://k3s.io/) – Lightweight Kubernetes
- [Istio](https://istio.io/) – Service Mesh
- [Prometheus](https://prometheus.io/) – Metrics collection
- [Grafana](https://grafana.com/) – Metrics visualization
- [Kiali](https://kiali.io/) – Service Mesh visualization

---

## Project Structure
```bash
Canary-Istio/
│── echo-canary.yaml # Deployment for echo service (v1 & v2)
│── test-canary.sh # Script to generate traffic
│── vs-50-50.yaml # VirtualService with 50/50 split
│── vs-100-0-v2.yaml # VirtualService sending 100% to v2
│── vs-rollback-v1.yaml # VirtualService rollback to v1
│── Screenshots/ # Screenshots for documentation
```

---

## Setup & Deployment

### Install K3s
```bash
curl -sfL https://get.k3s.io | sh -
kubectl get nodes
```
### Install Istio
```bash
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
```
### Deploy the Echo App
```bash
kubectl apply -f echo-canary.yaml
```
### Apply Traffic Routing
```bash
# 50/50 traffic split
kubectl apply -f vs-50-50.yaml

# 100% traffic to v2
kubectl apply -f vs-100-0-v2.yaml

# Rollback to v1
kubectl apply -f vs-rollback-v1.yaml
```
### Generate Traffic
```bash
chmod +x test-canary.sh
./test-canary.sh http://localhost:8080 50
```

---

## Observability

### Kiali
```bash
kubectl -n istio-system port-forward svc/kiali 20001:20001
open - http://localhost:20001
```
### Grafana 
```bash
kubectl -n istio-system port-forward svc/grafana 3000:3000
open - http://localhost:3000
```
### Prometheus
```bash
kubectl -n istio-system port-forward svc/prometheus 9090:9090
open - http://localhost:9090
```

---

## Screenshots
```bash
Some key screenshots included in Screenshots/:
- Istio Installation
- Canary Traffic Test Results 
- Grafana Dashboard
- Kiali Traffic Graph 
- Prometheus Metrics 
- Full v2 rollout
- Rollback to v1
```

---

## Key Learnings
```bash 
- Performed Canary Deployment using Istio traffic routing

- Observed traffic distribution with Kiali

- Monitored performance with Prometheus & Grafana

- Implemented rollback strategy for safe releases

- Strengthened hands-on Kubernetes + Service Mesh expertise
```
# THANK YOU
