# Engineering Standards

> This document defines the engineering principles, coding standards, documentation guidelines, and project conventions followed throughout the Enterprise OKD on OCI project.

---

# 1. Purpose

The objective of this document is to establish a consistent engineering standard for the project.

Following common standards improves:

- Readability
- Maintainability
- Collaboration
- Automation
- Troubleshooting
- Reproducibility

This document acts as the project's engineering guideline.

---

# 2. Engineering Philosophy

This project is built using the following principles:

- Understand before implementing.
- Design before coding.
- Automate before repeating.
- Document while learning.
- Keep infrastructure reproducible.
- Keep configurations modular.
- Never hardcode sensitive information.
- Every resource must have a clear purpose.

---

# 3. Learning Methodology

Every topic in this repository follows the same structure.

1. Purpose
2. Theory
3. Why it exists
4. Architecture
5. Data Flow
6. OCI Console
7. Terraform Implementation
8. Enterprise Best Practices
9. Azure Comparison
10. Troubleshooting
11. Interview Questions
12. Revision Notes

This ensures every concept is learned consistently.

---

# 4. Documentation Standards

All documentation is written in Markdown.

Reason:

- Easy to version control
- GitHub friendly
- Searchable
- Lightweight
- Industry standard

Avoid using Word documents for technical documentation.

---

# 5. Folder Naming Standards

Use lowercase folder names.

Correct

docs/
terraform/
scripts/
diagrams/
screenshots/

Incorrect

Documents/
Terraform/
Scripts/

Reason:

Linux filesystems are case-sensitive.

---

# 6. File Naming Standards

Use lowercase with hyphens.

Examples

03-terraform-architecture.md

07-networking.md

14-okd-installation.md

Avoid

TerraformArchitecture.md

networkingNotes.md

---

# 7. Terraform Standards

Terraform files should have a single responsibility.

Example

versions.tf

Terraform version and provider definitions.

provider.tf

Provider configuration.

variables.tf

Input variables.

outputs.tf

Output values.

locals.tf

Computed local values.

network.tf

Networking resources.

compute.tf

Compute resources.

security.tf

Security resources.

storage.tf

Storage resources.

---

# 8. Variable Standards

Never hardcode values that may change.

Bad

cidr_block = "10.0.0.0/16"

Good

cidr_block = var.vcn_cidr

Reason

Different environments should require only variable changes, not code changes.

---

# 9. Secret Management

Never commit:

- Private SSH Keys
- OCI API Keys
- Terraform State
- Passwords
- Tokens
- Certificates
- terraform.tfvars (when it contains secrets)

Always use:

.gitignore

for sensitive files.

---

# 10. Git Standards

Commit frequently.

Each commit should represent one logical change.

Good examples

Initialize Terraform project

Add provider configuration

Create networking module

Configure OCI provider

Avoid

Final Changes

Updates

Misc Fixes

---

# 11. Terraform Formatting

Every change should be validated before committing.

terraform fmt

terraform validate

terraform plan

Only then:

terraform apply

---

# 12. Enterprise Design Principles

Infrastructure should be:

Repeatable

Version Controlled

Idempotent

Modular

Secure

Automated

Documented

---

# 13. Resource Design Principles

Every resource must answer:

Why does it exist?

Who uses it?

What happens if it is removed?

Is it temporary?

Is it reusable?

How is it secured?

How is it monitored?

---

# 14. OCI Learning Standards

Every OCI service should be understood from five perspectives.

Concept

Architecture

Packet Flow

Terraform

Enterprise Usage

---

# 15. Azure Comparison

Every major OCI component will include:

OCI Equivalent

Azure Equivalent

AWS Equivalent

The objective is to understand concepts instead of memorizing cloud-specific terminology.

---

# 16. Interview Preparation

Every chapter must include:

Easy Questions

Medium Questions

Scenario Questions

Architecture Questions

Common Mistakes

STAR Discussion (where applicable)

---

# 17. Repository Evolution

The repository will evolve in three stages.

Stage 1

Learning

Simple Terraform structure

Stage 2

Modularization

Terraform modules

Stage 3

Production

Remote state

CI/CD

Policy checks

Environment separation

---

# 18. Living Documentation

This repository is a living knowledge base.

Whenever a new concept is learned:

- Add it to the most appropriate chapter.
- Do not create duplicate notes.
- Update diagrams if architecture changes.
- Record lessons learned after troubleshooting.

Documentation grows together with the project.

---

# 19. Definition of Done

A topic is complete only when:

✓ Theory is understood

✓ Architecture is documented

✓ Terraform implementation works

✓ Validation is completed

✓ Troubleshooting notes are added

✓ Interview questions are answered

✓ Documentation is updated

---

# 20. Project Goal

The goal of this project is not only to deploy OKD.

The goal is to understand, design, automate, document, operate, and explain an enterprise-grade cloud platform using modern Infrastructure as Code practices.