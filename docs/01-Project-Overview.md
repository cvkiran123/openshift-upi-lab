# Enterprise OKD Platform on Oracle Cloud Infrastructure (OCI)

> **Project Type:** Platform Engineering | Infrastructure as Code | OpenShift/OKD
>
> **Author:** Kiran
>
> **Status:** In Progress

---

# 1. Project Overview

This project demonstrates the end-to-end design, deployment, automation, and operation of an enterprise-grade **OKD (OpenShift Kubernetes Distribution)** platform on **Oracle Cloud Infrastructure (OCI)** using modern DevOps and Platform Engineering practices.

Rather than focusing only on installing OKD, this project emphasizes understanding the complete infrastructure lifecycle, including networking, security, automation, documentation, troubleshooting, and operational best practices.

The infrastructure will be provisioned using **Terraform**, configured using **Ansible**, and deployed using the **User-Provisioned Infrastructure (UPI)** installation method.

---

# 2. Project Objectives

The primary objectives of this project are:

- Learn Oracle Cloud Infrastructure architecture.
- Understand enterprise networking design.
- Deploy OKD using the UPI installation method.
- Provision infrastructure using Terraform.
- Configure compute instances using Ansible.
- Learn Infrastructure as Code (IaC) principles.
- Understand OpenShift architecture and components.
- Build a production-style GitHub portfolio project.
- Prepare for Platform Engineer, DevOps Engineer, and OpenShift Administrator interviews.

---

# 3. Problem Statement

Enterprise Kubernetes platforms consist of many interconnected cloud resources such as virtual networks, compute instances, storage, routing, DNS, load balancers, and security policies.

Manually creating these resources is:

- Time consuming
- Error prone
- Difficult to reproduce
- Difficult to audit
- Difficult to version control

Infrastructure as Code solves these problems by describing infrastructure declaratively using code.

---

# 4. Scope

This project includes the design and implementation of:

## Oracle Cloud Infrastructure

- Compartments
- Identity and Access Management (IAM)
- Virtual Cloud Network (VCN)
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Service Gateway
- Route Tables
- Network Security Groups (NSGs)
- Security Lists
- DNS
- Compute Instances
- Boot Volumes
- Block Volumes
- Load Balancers

---

## Infrastructure as Code

Terraform

- Provider configuration
- Variables
- Outputs
- Locals
- Modules
- State Management
- Dependency Graph
- Resource Lifecycle

---

## Configuration Management

Ansible

- Inventory
- Playbooks
- Roles
- SSH configuration
- Linux configuration

---

## OpenShift / OKD

- UPI Installation
- Bootstrap Node
- Control Plane
- Worker Nodes
- Ignition
- DNS
- Load Balancer
- Cluster Validation

---

## Operations

- Scaling
- Troubleshooting
- Resource cleanup
- Cost optimization
- Validation
- Documentation

---

# 5. Out of Scope

The following topics are intentionally excluded from the first version of the project.

- CI/CD Pipelines
- Monitoring Stack (Prometheus/Grafana)
- Logging Stack
- GitOps (Argo CD)
- Service Mesh
- OpenShift Virtualization
- Disaster Recovery
- Multi-Cluster Management

These may be added in future phases.

---

# 6. Technology Stack

| Category | Technology |
|-----------|------------|
| Cloud | Oracle Cloud Infrastructure |
| Operating System | Ubuntu Server |
| Container Platform | OKD |
| IaC | Terraform |
| Configuration Management | Ansible |
| Version Control | Git |
| Repository | GitHub |
| Shell | Bash |
| SSH | OpenSSH |
| Documentation | Markdown |
| Diagrams | Draw.io |

---

# 7. High-Level Architecture

```
                        GitHub
                           │
                    Terraform Code
                           │
                  terraform apply
                           │
                  OCI Provider Plugin
                           │
                     OCI REST API
                           │
────────────────────────────────────────────────────

Oracle Cloud Infrastructure

    Compartments

    Networking
    ├── VCN
    ├── Internet Gateway
    ├── NAT Gateway
    ├── Route Tables
    ├── NSGs
    └── Subnets

    Compute
    ├── Bastion
    ├── Bootstrap
    ├── Masters
    └── Workers

    Storage
    ├── Boot Volumes
    └── Block Volumes

────────────────────────────────────────────────────

            Ansible Configuration

────────────────────────────────────────────────────

             OKD Installation

────────────────────────────────────────────────────

             Running Cluster
```

---

# 8. Project Phases

## Phase 1

OCI Fundamentals

- Networking
- Security
- Compute
- Storage

---

## Phase 2

Terraform Foundation

- Providers
- State
- Variables
- Outputs
- Modules

---

## Phase 3

Infrastructure Provisioning

- Networking
- Security
- Compute
- Storage

---

## Phase 4

Server Configuration

- SSH
- Linux
- Ansible

---

## Phase 5

OKD Installation

- Bootstrap
- Masters
- Workers

---

## Phase 6

Validation

- Cluster Operators
- API
- Ingress
- Console

---

## Phase 7

Operations

- Scaling
- Cleanup
- Troubleshooting
- Cost Optimization

---

# 9. Enterprise Design Principles

The project follows the following engineering principles.

- Infrastructure as Code
- Version Control
- Least Privilege
- Modular Design
- Repeatability
- Automation
- Documentation
- Security by Design
- Cost Optimization

---

# 10. Learning Methodology

Every topic in this project follows the same structure.

1. Theory
2. Why the component exists
3. Architecture
4. Data Flow
5. OCI Console implementation
6. Terraform implementation
7. Enterprise best practices
8. Azure comparison
9. Interview questions
10. Troubleshooting

The objective is not to memorize commands but to understand the architecture and reasoning behind each design decision.

---

# 11. Expected Learning Outcomes

After completing this project, the following skills should be developed.

Cloud

- Oracle Cloud Infrastructure
- Cloud Networking
- Compute
- Storage
- Security

Terraform

- Infrastructure as Code
- Providers
- Modules
- State
- Resource Lifecycle

Linux

- SSH
- Networking
- Storage
- Process Management

OpenShift

- UPI Installation
- Cluster Architecture
- Bootstrap
- Control Plane
- Workers

DevOps

- Automation
- Documentation
- Troubleshooting
- Git
- Platform Engineering

---

# 12. Success Criteria

The project is considered complete when:

- Infrastructure is provisioned using Terraform.
- Compute instances are configured automatically.
- OKD is successfully deployed.
- Bootstrap node is removed after installation.
- Cluster operators become healthy.
- Console is accessible.
- Documentation is complete.
- The project is reproducible using Infrastructure as Code.

---

# 13. Repository Structure

```
openshift-upi-lab/

docs/

terraform/

scripts/

diagrams/

screenshots/

README.md
```

---

# 14. Target Audience

This project is intended for:

- DevOps Engineers
- Platform Engineers
- Cloud Engineers
- OpenShift Administrators
- Kubernetes Administrators
- Students learning Infrastructure as Code

---

# 15. Project Philosophy

The goal of this repository is not simply to deploy an OKD cluster.

The goal is to understand **why every component exists,
how it interacts with other components, and how enterprise organizations design, automate,
operate, and troubleshoot cloud-native platforms.**
