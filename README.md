# Docker + Terraform CI/CD Pipeline

## 📌 Project Overview

This project demonstrates a complete DevOps workflow that integrates Infrastructure as Code (Terraform) with containerization (Docker) and CI/CD automation (Jenkins).

It automates infrastructure provisioning and application deployment using industry best practices.

---

## 🏗 Architecture

Developer → GitHub → Jenkins Pipeline → Docker Build → Terraform Provisioning → Application Deployment

---

## 🛠 Tools & Technologies Used

- AWS
- Terraform (Infrastructure as Code)
- Docker
- Jenkins (CI/CD Pipeline)
- Linux
- Git

---

## 🚀 Workflow

1. Code is pushed to GitHub.
2. Jenkins pipeline is triggered.
3. Docker image is built using Dockerfile.
4. Terraform provisions infrastructure.
5. Application is deployed automatically.

---

## 📂 Repository Structure

- `terraform/` → Infrastructure configuration files
- `Dockerfile` → Application container definition
- `Jenkinsfile` → CI/CD pipeline configuration
- `test.py` → Sample Python application

---

## ▶️ How to Run

```bash
# Initialize Terraform
terraform init

# Plan infrastructure
terraform plan

# Apply configuration
terraform apply
```

---

## 🎯 Objective

To implement Infrastructure as Code (IaC) and automate application deployment using DevOps best practices.

This project reflects hands-on experience with real-world DevOps tools and workflows.
