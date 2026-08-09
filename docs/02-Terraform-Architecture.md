# Terraform Architecture

---

# 1. Purpose

The purpose of this chapter is to understand how Terraform actually works internally before writing any Infrastructure as Code (IaC).

Before writing a single resource, we must understand:

- How Terraform works
- Why providers exist
- How Terraform communicates with OCI
- What happens during `terraform init`
- How resources are created
- Why Terraform is cloud-independent

Understanding this architecture makes learning Terraform significantly easier.

---

# 2. What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp.

Instead of manually creating cloud resources through a web console, Terraform allows infrastructure to be described declaratively using code.

Example:

Instead of manually creating:

- Virtual Networks
- Virtual Machines
- Storage
- Route Tables

we simply describe the desired infrastructure.

Terraform then determines the required API calls to create or modify that infrastructure.

Terraform does **not** directly create resources.

It communicates with cloud providers using their APIs.

---

# 3. Infrastructure as Code (IaC)

Infrastructure as Code means describing infrastructure using version-controlled code rather than manual configuration.

Traditional approach

Developer

↓

Cloud Console

↓

Click

↓

Click

↓

Click

↓

Infrastructure

Infrastructure as Code

Developer

↓

Terraform Code

↓

Version Control

↓

terraform apply

↓

Infrastructure

Benefits

- Repeatable
- Automated
- Auditable
- Version Controlled
- Easier Disaster Recovery
- Reduced Human Error

---

# 4. High-Level Terraform Architecture

```

Developer
│
│ terraform apply
▼
Terraform CLI
│
▼
Terraform Core
│
▼│
▼
Cloud SDK
│
▼
REST API
│
▼
Cloud Control Plane
│
▼
Cloud Infrastructure

```

The cloud provider performs the actual resource creation.

---

# 5. Terraform Components

## 5.1 Terraform CLI

The Terraform CLI is the executable that users interact with.

Example

```

terraform init

terraform plan

terraform apply

terraform destroy

```

The CLI loads Terraform Core and the required providers.

---

## 5.2 Terraform Core

Terraform Core is the engine responsible for:

- Reading HCL files
- Parsing configuration
- Creating dependency graphs
- Comparing desired state with current state
- Planning changes
- Calling providers
- Managing state

Terraform Core does **not** understand OCI, Azure, AWS, or Kubernetes.

Terraform Core is cloud-independent.

---

## 5.3 Provider

A provider is a plugin that understands a specific platform.

Examples

OCI Provider

AzureRM Provider

AWS Provider

Kubernetes Provider

GitHub Provider

The provider contains:

- Authentication logic
- API mappings
- Resource definitions
- Validation rules
- Error handling

---

## 5.4 SDK

Most providers do not directly construct HTTP requests.

Instead, they use an official SDK.

OCI Provider

↓

OCI Go SDK

↓

OCI REST API

The SDK already understands:

- Authentication
- Request formatting
- Retry logic
- API endpoints

---

## 5.5 REST API

Every cloud provider exposes REST APIs.

Terraform eventually sends HTTPS requests to these APIs.

Example

POST /instances

POST /vcns

DELETE /subnets

The OCI Console, OCI CLI, Terraform, and SDKs all communicate with the same OCI REST APIs.

---

# 6. Resource Creation Flow

Suppose we define the following Terraform resource.

resource "oci_core_vcn" "platform" {}

What happens internally?

Step 1

Terraform reads HCL.

↓

Step 2

Terraform Core parses the configuration.

↓

Step 3

Terraform identifies that the OCI Provider is required.

↓

Step 4

OCI Provider receives the request.

↓

Step 5

OCI Provider uses the OCI SDK.

↓

Step 6

OCI SDK sends HTTPS requests.

↓

Step 7

OCI REST API authenticates the request.

↓

Step 8

OCI Control Plane provisions the VCN.

↓

Step 9

Terraform stores the resource information in its state.

---

# 7. Why Providers Exist

Terraform Core is intentionally cloud-independent.

It does not know:

- OCI APIs
- Azure APIs
- AWS APIs

Instead, providers translate Terraform resources into cloud-specific API requests.

Benefits

- Modular architecture
- Independent releases
- Smaller Terraform binary
- Easier maintenance
- Support for thousands of providers

---

# 8. Why Providers Are Downloaded Separately

Providers are plugins.

Terraform downloads only the required providers during `terraform init`.

Advantages

- Smaller installation size
- Independent versioning
- Faster updates
- Modular architecture

This is similar to extensions in Visual Studio Code.

---

# 9. Terraform vs Cloud Provider

Terraform does not create infrastructure.

Cloud providers create infrastructure.

Responsibilities

Terraform

- Reads configuration
- Creates execution plan
- Calls providers
- Maintains state

OCI

- Creates resources
- Allocates compute
- Configures networking
- Attaches storage

---

# 10. OCI Comparison

Different OCI tools use the same APIs.

OCI Console

↓

OCI REST API

OCI CLI

↓

OCI REST API

Terraform

↓

OCI REST API

Python SDK

↓

OCI REST API

Go SDK

↓

OCI REST API

Everything ultimately communicates with the OCI Control Plane.

---

# 11. Azure Comparison

Terraform Core

↓

AzureRM Provider

↓

Azure REST API

↓

Azure Resource Manager

↓

Azure Infrastructure

The architecture remains identical.

Only the provider changes.

---

# 12. Enterprise Best Practices

- Pin Terraform versions.
- Pin provider versions.
- Never use "latest" in production.
- Keep providers separate from Terraform Core.
- Commit code, never state files.
- Use version control.
- Review plans before applying.

---

# 13. Common Mistakes

- Thinking Terraform creates infrastructure.
- Believing Terraform communicates directly with hypervisors.
- Assuming providers are part of Terraform Core.
- Using latest provider versions.
- Ignoring provider documentation.

---

# 14. Key Takeaways

Terraform is an orchestration engine.

Terraform Core is cloud-independent.

Providers contain cloud-specific logic.

Providers communicate using cloud SDKs.

SDKs call REST APIs.

Cloud providers create resources.

Terraform records resource state.

---

# 15. Interview Questions

## Easy

What is Terraform?

What is Infrastructure as Code?

Why use Terraform?

---

## Medium

Why does Terraform require providers?

What is Terraform Core?

What happens during `terraform apply`?

---

## Hard

Why are providers released independently from Terraform Core?

How would Terraform support a newly released OCI service?

Why is Terraform considered cloud-independent?

---

# 16. Summary

Terraform does not directly provision infrastructure.

Terraform Core analyzes the desired infrastructure and delegates cloud-specific operations to providers.

Providers use cloud SDKs to communicate with REST APIs.

The cloud provider performs the actual resource provisioning, while Terraform maintains the desired state and resource lifecycle.

Understanding this architecture is the foundation for all subsequent Terraform concepts.
Understanding this architecture is the foundation for all subsequent Terraform concepts.
Understanding this architecture is the foundation for all subsequent Terraform concepts.
Understanding this architecture is the foundation for all subsequent Terraform concepts.
Understanding this architecture is the foundation for all subsequent Terraform concepts.
Understanding this architecture is the foundation for all subsequent Terraform concepts.
