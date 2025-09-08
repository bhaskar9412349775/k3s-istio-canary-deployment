# Project Report: Kubernetes-Based Canary Deployment with K3s and Istio

## 1. Introduction
```bash
This project demonstrates progressive delivery using Canary Deployments on Kubernetes with Istio Service Mesh.
The objective was to gradually roll out a new version of an application while monitoring traffic, ensuring reliability, and enabling rollback if issues occur.

Technologies used:

- K3s – lightweight Kubernetes distribution

- Istio – service mesh for traffic management, observability, and security

- Prometheus, Grafana, Kiali – observability stack
```

---

## 2. Project Objectives
```bash
- Set up a lightweight Kubernetes cluster using K3s.

- Deploy a sample echo application (v1 & v2).

- Use Istio Gateway + VirtualService for traffic splitting.

- Perform Canary Deployment with traffic routing:

- Start: 80/20 → gradually move traffic to v2

- Progress: 50/50

- Promote: 100% to v2

- Rollback: 100% back to v1

- Visualize traffic distribution in Kiali.

- Monitor performance metrics using Prometheus + Grafana.
```

---

## 3. System Architecture
```bash
Traffic Flow
Client (http://localhost:8080)
       ↓
Port-Forward (8080 → 80)
       ↓
Istio IngressGateway (Port 80)
       ↓
Istio VirtualService (Traffic Split)
       ↓
Echo Service
  ↙        ↘
echo-v1   echo-v2
- External Port: 8080 (via port-forward)

- Ingress Gateway Port: 80

- Pod Container Port: 8080
```

---

## 4. Implementation Steps
```bash
4.1 Prerequisites

- Ubuntu OS

- Docker installed

- K3s installed with Traefik disabled
curl -sfL https://get.k3s.io | sh -s - --disable=traefik

- Istio installed (demo profile)
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
```
```bash
4.2 Deployment Files

- echo-canary.yaml → Deployments (v1 & v2), Service, DestinationRule, Gateway, VirtualService

- vs-50-50.yaml → Traffic split 50/50

- vs-100-0-v2.yaml → Full rollout to v2

- vs-rollback-v1.yaml → Rollback to v1

- test-canary.sh → Script to generate test traffic
```
```bash
4.3 Canary Rollout Strategy

Initial Deployment (80/20)

- Most traffic goes to v1, some to v2.

- Verify v2 stability before promotion.

Gradual Shift (50/50)

- Balanced traffic distribution between v1 and v2.

Full Rollout (100% v2)

- All traffic routed to v2.

Rollback (100% v1)

- In case of issues, revert to stable v1.
```
```bash
4.4 Observability

- Kiali → Visualizes real-time traffic distribution.

- Grafana → Performance dashboards.

- Prometheus → Metrics collection.
```

---

## 5. Results
```bash
Successfully implemented canary deployment:

- Verified traffic shifts (80/20 → 50/50 → 100/0).

- Rollback worked without downtime.

- Observability tools showed clear traffic routing and metrics.

Screenshots collected for evidence:

- Istio installation success

- Pods running (echo-v1, echo-v2 with sidecars)

- Test traffic results (test-canary.sh)

- Kiali traffic distribution graph

- Prometheus metrics

- Grafana dashboard

- Rollback verification
```

---

## 6. Challenges Faced & Solutions
```bash
Issue: Ingress external IP stuck at <pending>

- Fix: Used port-forward kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80

Issue: No istio-proxy sidecar injected

- Fix: Re-labeled namespace with istio-injection=enabled and restarted deployments

Issue: Traefik conflict with Istio

- Fix: Disabled Traefik during K3s install
```

---

## 7. Conclusion
```bash
This project demonstrates practical skills in Kubernetes, Istio, traffic management, and observability, which are highly valued in modern DevOps roles.
It showcases the ability to implement progressive delivery, monitor deployments in real-time, and ensure safe rollouts with rollback strategies.
```
