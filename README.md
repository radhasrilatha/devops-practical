# Swimlane DevOps Practical

## Overview

This project demonstrates the deployment of the Swimlane DevOps Practical application on Amazon EKS using Docker, Terraform, and Helm.

The application and MongoDB were containerized, deployed to Kubernetes, and verified by registering a user and creating a new article through the application UI.

---

# Kubernetes Cluster Setup

An Amazon EKS cluster was provisioned using Terraform.

Infrastructure created:

* VPC
* Public and Private Subnets
* Internet Gateway
* NAT Gateway
* Amazon EKS Cluster
* Managed Node Group

After the cluster was created, the kubeconfig was updated using:

```bash
aws eks update-kubeconfig --region us-east-1 --name swimlane-eks
```

Verify the cluster:

```bash
kubectl get nodes
```

---

# Docker

Build the application image:

```bash
docker build -t swimlane-app .
```

Run locally using Docker Compose:

```bash
docker compose up -d
```

MongoDB is deployed as a Docker container through `docker-compose.yaml`.

---

# Terraform Deployment

Navigate to the Terraform directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Provision infrastructure:

```bash
terraform apply
```

Destroy infrastructure:

```bash
terraform destroy
```

Terraform files are located in:

```text
terraform/
```

---

# Helm Deployment

The application is deployed using a Helm chart.

Install:

```bash
helm install swimlane ./helm/swimlane --namespace swimlane --create-namespace
```

Upgrade:

```bash
helm upgrade swimlane ./helm/swimlane -n swimlane
```

Uninstall:

```bash
helm uninstall swimlane -n swimlane
```

Verify deployment:

```bash
kubectl get pods -n swimlane
kubectl get svc -n swimlane
```

Helm chart location:

```text
helm/swimlane/
```

---

# Project Structure

```text
.
├── Dockerfile
├── docker-compose.yaml
├── .dockerignore
├── README.md
│
├── terraform/
│   ├── providers.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── eks.tf
│   └── outputs.tf
│
├── helm/
│   └── swimlane/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│
└── screenshots/
```

---

# Deliverables

This repository contains:

* Dockerfile
* docker-compose.yaml
* Terraform files for provisioning AWS infrastructure and EKS
* Helm chart used to deploy the application
* Kubernetes manifests included within the Helm chart
* README with deployment steps
* Screenshots of the deployed application

---

# Screenshots

The `screenshots/` directory contains:

* Running application
* Registered user
* New article created through the application
* (Optional) Kubernetes pods and services

Example:

```text
screenshots/
├── application-home.png
├── article-created.png
└── kubernetes-pods.png
```

---

# Verification

The deployment was successfully verified by:

* Deploying the application on Amazon EKS
* Accessing the application through the Kubernetes LoadBalancer
* Registering a new user
* Logging into the application
* Creating a new article
* Confirming application functionality
