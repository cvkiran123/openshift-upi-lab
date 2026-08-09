# Terraform CLI Lifecycle

> **Document Version:** 1.0  
> **Status:** Draft  
> **Author:** Kiran  
> **Category:** Terraform Foundation  
> **Prerequisites:**  
> - 00-engineering-standards.md
> - 01-project-overview.md
> - 02-terraform-architecture.md

---

# 1. Purpose

The Terraform CLI (Command Line Interface) is the primary tool used to interact with Terraform projects.

This chapter explains the lifecycle of a Terraform project, the purpose of each CLI command, and how enterprise teams use these commands to safely provision and manage infrastructure.

---

# 2. Why Terraform Has Multiple Commands

Terraform intentionally separates the infrastructure lifecycle into multiple stages.

Instead of directly creating infrastructure, Terraform performs validation and planning before making changes.

This design reduces the risk of accidental infrastructure modifications.

---

# 3. Terraform Lifecycle

```

Developer

↓

terraform init

↓

terraform fmt

↓

terraform validate

↓

terraform plan

↓

Review Plan

↓

terraform apply

↓

Infrastructure Created

↓

terraform destroy

↓

Infrastructure Removed

```

Every command has a specific responsibility.

---

# 4. Command Overview

| Command | Purpose | Contacts OCI? |
|----------|---------|---------------|
| terraform init | Initialize project | No |
| terraform fmt | Format Terraform code | No |
| terraform validate | Validate configuration | No |
| terraform plan | Generate execution plan | Yes (may refresh state unless disabled) |
| terraform apply | Create/Modify/Delete infrastructure | Yes |
| terraform destroy | Delete infrastructure | Yes |

---

# 5. terraform init

## Purpose

Initializes the working directory.

## Responsibilities

- Downloads providers
- Downloads modules
- Creates `.terraform/`
- Creates `.terraform.lock.hcl`

## What it DOES NOT do

- Does not create resources
- Does not authenticate with OCI for provisioning
- Does not modify infrastructure

## Typical Usage

```bash
terraform init
```

---

# 6. terraform fmt

## Purpose

Formats Terraform code according to HashiCorp's standard style.

Example:

Before

```hcl
resource"oci_core_vcn""main"{
cidr_blocks=["10.0.0.0/16"]
}
```

After

```hcl
resource "oci_core_vcn" "main" {
  cidr_blocks = ["10.0.0.0/16"]
}
```

## Why?

Consistent formatting improves readability and simplifies code reviews.

## Typical Usage

```bash
terraform fmt
```

---

# 7. terraform validate

## Purpose

Validates the Terraform configuration.

Terraform checks:

- Syntax
- Provider configuration
- Variable definitions
- Resource references

## What it DOES NOT do

- Does not create infrastructure
- Does not execute API requests

## Typical Usage

```bash
terraform validate
```

---

# 8. terraform plan

## Purpose

Compares the desired configuration with the current infrastructure state and generates an execution plan.

Terraform determines:

- Resources to create
- Resources to modify
- Resources to delete

## Symbols

```
+ Create

~ Modify

- Destroy
```

## Why is it important?

The plan allows engineers to review changes before infrastructure is modified.

## Typical Usage

```bash
terraform plan
```

---

# 9. terraform apply

## Purpose

Executes the plan and provisions infrastructure.

Terraform:

- Calls the provider
- Provider calls OCI APIs
- OCI provisions infrastructure
- Terraform updates state

## Typical Usage

```bash
terraform apply
```

---

# 10. terraform destroy

## Purpose

Deletes infrastructure managed by Terraform.

Terraform compares the state file with the configuration and issues delete requests for managed resources.

## Typical Usage

```bash
terraform destroy
```

---

# 11. Internal Execution Flow

```

Developer

↓

terraform apply

↓

Terraform CLI

↓

Terraform Core

↓

OCI Provider

↓

OCI SDK

↓

OCI REST API

↓

OCI Control Plane

↓

Infrastructure Created

```

Terraform itself never creates infrastructure.

OCI performs the actual provisioning.

---

# 12. Enterprise Workflow

Infrastructure changes should never go directly from code to production.

Typical workflow:

```

Developer

↓

terraform fmt

↓

terraform validate

↓

terraform plan

↓

Peer Review

↓

Approval

↓

terraform apply

↓

Production

```

Many organizations automate this workflow using CI/CD pipelines.

---

# 13. Best Practices

- Always initialize a new project with `terraform init`.
- Run `terraform fmt` before committing code.
- Run `terraform validate` to catch configuration errors early.
- Review `terraform plan` carefully before applying changes.
- Avoid running `terraform apply` directly against production without review.
- Use version control for all Terraform code.

---

# 14. Common Mistakes

❌ Running `terraform apply` without reviewing the plan.

❌ Ignoring formatting.

❌ Skipping validation.

❌ Running `terraform destroy` in the wrong workspace or environment.

❌ Assuming `terraform init` creates infrastructure.

---

# 15. OCI Perspective

Terraform interacts with OCI only through the OCI Provider.

The provider communicates with the OCI REST APIs.

```

Terraform CLI

↓

Terraform Core

↓

OCI Provider

↓

OCI REST API

↓

OCI Control Plane

↓

OCI Infrastructure

```

---

# 16. Azure Comparison

The Terraform workflow remains the same across cloud providers.

| Terraform | OCI | Azure |
|------------|-----|--------|
| Provider | OCI Provider | AzureRM Provider |
| API | OCI REST API | Azure Resource Manager (ARM) API |
| Infrastructure | OCI Resources | Azure Resources |

Only the provider changes.

---

# 17. Interview Questions

## Easy

- What is Terraform CLI?
- What is the purpose of `terraform init`?
- What is the purpose of `terraform fmt`?

---

## Medium

- Explain the difference between `terraform validate` and `terraform plan`.
- What does `terraform apply` do internally?
- Why should `terraform plan` always be reviewed?

---

## Advanced

- Explain the complete Terraform execution lifecycle.
- Why does Terraform separate planning from applying?
- How would you safely deploy infrastructure changes in production?

---

# 18. Revision Notes

Remember the command sequence:

```
terraform init

↓

terraform fmt

↓

terraform validate

↓

terraform plan

↓

terraform apply

↓

terraform destroy
```

Think of it as:

**Prepare → Format → Validate → Preview → Execute → Remove**

---

# 19. Key Takeaways

- Terraform follows a structured lifecycle.
- Initialization, validation, and planning reduce deployment risk.
- `terraform plan` provides visibility before changes are applied.
- `terraform apply` is the only command that modifies infrastructure.
- Enterprise teams use reviews and automation before applying changes to production.