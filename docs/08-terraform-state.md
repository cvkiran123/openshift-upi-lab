# Terraform State (terraform.tfstate)

> **Document Version:** 1.0
>
> **Status:** Draft
>
> **Author:** Kiran
>
> **Category:** Terraform Foundation
>
> **Prerequisites**
>
> - 00-engineering-standards.md
> - 01-project-overview.md
> - 02-terraform-architecture.md
> - 03-terraform-cli-lifecycle.md
> - 04-provider-authentication.md
> - 05-provider-tf.md
> - 06-variables-tf.md
> - 07-terraform-tfvars.md

---

# 1. Purpose

Terraform maintains a **state file** to record the infrastructure it manages.

Without state, Terraform would not know:

- Which resources it previously created.
- Which resources have changed.
- Which resources should be updated.
- Which resources should be deleted.

The state file is Terraform's memory.

---

# 2. Why Does Terraform Need State?

Suppose you create:

- 1 VCN
- 2 Subnets
- 3 Compute Instances

Tomorrow you modify only:

```hcl
shape = "VM.Standard.A1.Flex"
```

How does Terraform know:

- Don't recreate the VCN.
- Don't recreate the Subnets.
- Modify only the VM.

Answer:

Because Terraform reads the state file.

---

# 3. High-Level Architecture

```
Terraform Code
       │
       ▼
terraform.tfstate
       │
       ▼
Current Infrastructure
       │
       ▼
Terraform Plan
       │
       ▼
Terraform Apply
```

---

# 4. What is terraform.tfstate?

It is a JSON file created automatically by Terraform.

Example:

```
terraform/

├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
└── terraform.tfstate
```

The file contains information about every Terraform-managed resource.

---

# 5. What Information is Stored?

Terraform stores:

- Resource IDs
- OCIDs
- Resource Names
- Attributes
- Dependencies
- Metadata

Example:

```
VCN

OCID

CIDR

Subnets

VMs

Public IPs
```

Terraform uses this information to compare:

Desired State

vs

Actual State

---

# 6. Desired State vs Current State

Desired State

```
main.tf
```

Current State

```
terraform.tfstate
```

Actual Infrastructure

```
OCI Resources
```

Terraform compares all three before making changes.

---

# 7. Terraform Workflow

```
Developer

↓

terraform plan

↓

Read Configuration

↓

Read State

↓

Query OCI

↓

Compare

↓

Execution Plan
```

Then

```
terraform apply

↓

Execute Changes

↓

Update State File
```

---

# 8. Infrastructure Drift

Suppose Terraform creates:

```
VM Shape

VM.Standard.E2.1.Micro
```

Later,

someone manually changes it in OCI Console.

Terraform State

still says

```
VM.Standard.E2.1.Micro
```

OCI says

```
VM.Standard.E2.2
```

Terraform detects this difference.

This is called:

Infrastructure Drift.

---

# 9. State File Lifecycle

```
terraform init

↓

No State

↓

terraform apply

↓

terraform.tfstate Created

↓

terraform apply

↓

State Updated

↓

terraform destroy

↓

State Updated Again
```

---

# 10. Local State

Default location:

```
terraform/

terraform.tfstate
```

Advantages

- Simple
- Easy for learning

Disadvantages

- Not shared
- No locking
- Easy to lose
- Difficult for teams

---

# 11. Remote State

Enterprise teams store state remotely.

Examples

OCI

Object Storage

AWS

S3

Azure

Storage Account

Benefits

- Shared
- Backup
- Versioning
- Collaboration
- Locking (depending on backend)
- Disaster Recovery

---

# 12. State Locking

Imagine two engineers.

```
Kiran

↓

terraform apply
```

At the same time

```
Rahul

↓

terraform apply
```

Without locking,

both modify the same infrastructure.

Result:

Corruption.

State locking prevents simultaneous updates.

---

# 13. Security

The state file may contain:

- Resource IDs
- Public IPs
- Sensitive attributes
- Provider metadata

Never expose it publicly.

Never commit it to Git.

Always protect remote state with IAM permissions and encryption.

---

# 14. Why State is Important

Terraform is declarative.

It does not remember infrastructure by scanning your code alone.

It remembers through the state file.

Without state,

Terraform loses its memory.

---

# 15. OCI Example

You create:

```
VCN

↓

Subnet

↓

Compute Instance
```

Terraform records:

```
VCN OCID

Subnet OCID

Instance OCID
```

Later,

Terraform uses these OCIDs to update the correct resources.

---

# 16. Azure Comparison

OCI

```
terraform.tfstate

↓

OCI Resources
```

Azure

```
terraform.tfstate

↓

Azure Resources
```

AWS

```
terraform.tfstate

↓

AWS Resources
```

The concept is identical.

---

# 17. Common Mistakes

❌ Editing terraform.tfstate manually.

❌ Committing state to Git.

❌ Sharing state over email.

❌ Deleting state accidentally.

❌ Running multiple applies without locking.

---

# 18. Interview Questions

## Easy

- What is terraform.tfstate?
- Why does Terraform create a state file?

---

## Medium

- What happens if terraform.tfstate is deleted?
- What is infrastructure drift?

---

## Advanced

- Explain the Terraform state lifecycle.
- Why is remote state preferred?
- Why is state locking important?

---

# 19. Key Takeaways

- Terraform state is Terraform's memory.
- The state file maps Terraform resources to real cloud resources.
- Terraform compares configuration, state, and cloud infrastructure before making changes.
- Enterprise teams use remote state.
- State files must be protected because they may contain sensitive information.

---

# 20. Revision Notes

Remember:

```
Terraform Code

↓

Desired State

↓

terraform.tfstate

↓

Known State

↓

OCI

↓

Actual State

↓

Terraform Plan

↓

Terraform Apply
```

Terraform succeeds because it always knows:

- What you want.
- What it already created.
- What currently exists.