# Provider Authentication (OCI)

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

---

# 1. Purpose

This chapter explains how Terraform authenticates with Oracle Cloud Infrastructure (OCI).

Before Terraform can create any cloud resource, Oracle must verify:

- Who is making the request?
- Which tenancy owns the request?
- Which region should receive the request?
- Is the caller authorized?

Terraform answers these questions through the OCI Provider configuration.

---

# 2. Why Authentication is Required

Imagine anyone on the Internet could execute:

POST /instances

OCI would start creating virtual machines.

That would be a massive security issue.

Therefore every API request must include authentication information.

---

# 3. High-Level Authentication Flow

```
Developer

↓

terraform apply

↓

Terraform Core

↓

OCI Provider

↓

Read Authentication Details

↓

Generate Signed API Request

↓

OCI REST API

↓

OCI IAM

↓

Authentication Successful

↓

Resource Created
```

---

# 4. OCI Identity Components

Terraform must identify the following.

## User

Represents the identity performing the operation.

Every user has a unique OCID.

Example

```
ocid1.user....
```

---

## Tenancy

Represents the OCI account.

Everything belongs to a tenancy.

Example

```
ocid1.tenancy....
```

---

## Compartment

Logical container for OCI resources.

Terraform creates resources inside a compartment.

Example

```
ocid1.compartment....
```

---

## Region

Specifies the OCI region.

Example

```
ap-mumbai-1
```

---

# 5. Authentication Components

Terraform requires:

User OCID

↓

Tenancy OCID

↓

Fingerprint

↓

Private Key

↓

Region

These values allow Terraform to sign OCI API requests.

---

# 6. API Key Authentication

Unlike web applications,

Terraform does not use:

Username

Password

Instead it uses:

Public Key Cryptography.

Workflow

```
Private Key

↓

Digital Signature

↓

OCI API

↓

Public Key Verification

↓

Authenticated
```

The private key remains on your machine.

OCI stores only the public key.

---

# 7. Authentication Sequence

```
terraform apply

↓

Provider reads provider.tf

↓

Loads private key

↓

Signs request

↓

HTTPS Request

↓

OCI REST API

↓

OCI IAM verifies signature

↓

Authorized

↓

Resource Created
```

---

# 8. Provider Configuration

Terraform uses a provider block similar to:

```hcl
provider "oci" {
    tenancy_ocid     = var.tenancy_ocid
    user_ocid        = var.user_ocid
    fingerprint      = var.fingerprint
    private_key_path = var.private_key_path
    region           = var.region
}
```

Notice:

Nothing is hardcoded.

Everything comes from variables.

---

# 9. Why Variables?

Bad

```hcl
region = "ap-mumbai-1"
```

Good

```hcl
region = var.region
```

Reason

The same code should work for:

Development

Testing

Production

Only variable values change.

---

# 10. Enterprise Authentication

Large organizations rarely store API keys inside repositories.

Instead they use:

- OCI Instance Principals
- OCI Resource Principals
- Vaults
- Secret Managers
- CI/CD Credentials

API Keys are common for learning and local development.

---

# 11. Security Best Practices

Never commit:

- Private Keys
- API Keys
- Passwords
- Tokens
- terraform.tfvars (if it contains secrets)

Always use:

.gitignore

---

# 12. OCI Console Mapping

Terraform Field

↓

OCI Console

Tenancy OCID

Identity → Tenancy

User OCID

Identity → Users

Fingerprint

API Keys

Region

Region Selector

---

# 13. Azure Comparison

OCI

↓

API Key

↓

OCI IAM

Azure

↓

Service Principal / Managed Identity

↓

Microsoft Entra ID

AWS

↓

IAM User / IAM Role

↓

AWS IAM

The concept is similar across clouds.

Only the authentication mechanism differs.

---

# 14. Common Mistakes

Hardcoding credentials.

Committing private keys.

Using the root user.

Incorrect region.

Incorrect fingerprint.

Incorrect private key path.

---

# 15. Interview Questions

Easy

Why does Terraform require authentication?

Medium

What information does the OCI Provider need?

Advanced

Explain how Terraform authenticates with OCI using API keys.

How is this different from Azure Managed Identity?

---

# 16. Key Takeaways

Terraform never authenticates by itself.

The OCI Provider performs authentication.

Authentication is based on signed API requests.

Variables should be used instead of hardcoded values.

Enterprise environments typically use managed identities or secret management solutions instead of storing long-lived API keys.

OCI
 │
 ▼
Tenancy
 │
 ▼
IAM
 ├── Users
 ├── Groups
 └── Policies
 │
 ▼
Compartments
 │
 ▼
Resources

### Enterprise Identity Management

Permissions should be assigned to **Groups**, not individual Users.

Advantages:

- Easier onboarding and offboarding.
- Centralized permission management.
- Reduced administrative effort.
- Consistent access control.
- Better scalability.
- Supports the Principle of Least Privilege (PoLP).

Typical flow:

User
↓
Group
↓
IAM Policy
↓
Compartment
↓
Resources