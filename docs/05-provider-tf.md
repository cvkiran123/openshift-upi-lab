# Provider Configuration (provider.tf)

**Document Version:** 1.0

**Status:** Draft

**Prerequisites**

- Terraform Architecture
- Terraform CLI Lifecycle
- Provider Authentication

---

# 1. Purpose

A Terraform provider acts as the communication bridge between Terraform Core and Oracle Cloud Infrastructure (OCI).

Terraform Core itself does not know how to create OCI resources.

Instead, it delegates all OCI-specific operations to the OCI Provider.

The purpose of `provider.tf` is to configure how Terraform connects to OCI.

Without this configuration, Terraform cannot authenticate or communicate with Oracle Cloud.

---

# 2. Why provider.tf Exists

Terraform knows:

- How to read HCL
- How to compare state
- How to build dependency graphs

Terraform does NOT know:

- Which cloud?
- Which account?
- Which region?
- Which credentials?

The provider answers these questions.

---

# 3. High-Level Architecture

Developer

↓

Terraform CLI

↓

Terraform Core

↓

provider.tf

↓

OCI Provider

↓

OCI REST API

↓

OCI Control Plane

↓

OCI Resources

---

# 4. Responsibilities of provider.tf

The provider configuration tells Terraform:

- Which cloud provider to use.
- Which OCI region to communicate with.
- Which credentials to use.
- Which tenancy is being managed.

Think of it as configuring a database connection before running SQL queries.

---

# 5. Authentication Methods

Terraform supports multiple authentication mechanisms.

## Method 1 – API Key Authentication

Suitable for:

- Local development
- Learning
- Developer laptops

Uses:

- User OCID
- Tenancy OCID
- Fingerprint
- Private Key
- Region

---

## Method 2 – Instance Principal

Suitable for:

- OCI Compute Instances
- Jenkins running on OCI
- Production automation

Uses:

- OCI Instance Identity
- Dynamic Groups
- IAM Policies

No private key is required.

---

## Method 3 – Resource Principal

Suitable for:

- OCI Functions
- OCI Resource Manager
- OCI Services

---

## Method 4 – Security Token

Used for temporary authentication scenarios.

---

# 6. Which Method Are We Using?

For this project:

Phase 1

API Keys

Reason:

- Easier to understand.
- Demonstrates OCI authentication concepts.
- Works from a local laptop.

Phase 2

Instance Principals

Reason:

- Enterprise best practice.
- Removes long-lived credentials.
- Better security.

---

# 7. Provider Configuration

Example:

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

Every value comes from variables.

No hardcoded credentials.

---

# 8. Why Variables?

Instead of:

```hcl
region = "ap-mumbai-1"
```

We use:

```hcl
region = var.region
```

Benefits:

- Reusable
- Multi-environment
- Easier maintenance
- No code changes between environments

---

# 9. Enterprise Best Practices

Never hardcode:

- OCIDs
- API Keys
- Passwords
- Regions
- Compartments

Use:

- Variables
- Secret Managers
- Vaults
- Instance Principals
- Environment Variables

---

# 10. Common Mistakes

- Hardcoding credentials.
- Committing private keys.
- Using the root user.
- Incorrect region.
- Wrong private key path.
- Mixing multiple authentication methods.

---

# 11. OCI Console Mapping

Terraform Field            OCI Console

tenancy_ocid     → Identity → Tenancy

user_ocid        → Identity → Users

fingerprint      → API Keys

region           → Region Selector

private_key_path → Local Machine

---

# 12. Azure Comparison

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

---

# 13. Data Flow

terraform apply

↓

Terraform Core

↓

Reads provider.tf

↓

Loads Credentials

↓

Signs API Request

↓

OCI REST API

↓

OCI IAM

↓

Authorization

↓

OCI Resource Created

---

# 14. Interview Questions

Easy

- What is a Terraform Provider?

Medium

- What information is required in provider.tf?

Hard

- Explain the authentication flow between Terraform and OCI.

Scenario

- Why would you replace API Keys with Instance Principals in production?

---

# 15. Key Takeaways

- provider.tf configures Terraform's connection to OCI.
- Terraform Core delegates cloud operations to the OCI Provider.
- API Keys are appropriate for local development.
- Instance Principals are preferred for production workloads running inside OCI.
- Credentials should never be hardcoded.