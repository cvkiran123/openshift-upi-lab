# Terraform Variable Values (terraform.tfvars)

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

---

# 1. Purpose

`terraform.tfvars` supplies the actual values for variables defined in `variables.tf`.

It contains environment-specific configuration without changing the Terraform code.

This allows the same infrastructure code to be reused across multiple environments.

---

# 2. Why terraform.tfvars Exists

Consider the following variable definition.

```hcl
variable "region" {
  description = "OCI Region"
  type        = string
}
```

Terraform now knows:

- A variable named `region` exists.
- It must be a string.

Terraform still does **not** know the value.

That value is supplied in `terraform.tfvars`.

```hcl
region = "ap-mumbai-1"
```

---

# 3. High-Level Architecture

```
variables.tf
      │
Defines Variables
      │
      ▼
terraform.tfvars
      │
Supplies Values
      │
      ▼
provider.tf
      │
Uses Variables
      │
      ▼
OCI Provider
      │
      ▼
OCI API
```

---

# 4. Responsibility of terraform.tfvars

This file is responsible for supplying:

- OCI Identity
- Authentication Details
- Region
- Networking Values
- Compute Values
- Storage Values

depending on the project.

It does **not** define variables.

---

# 5. Current Project Example

```hcl
#############################################
# Identity
#############################################

tenancy_ocid = "ocid1.tenancy.oc1........"

user_ocid = "ocid1.user.oc1........"

#############################################
# Authentication
#############################################

fingerprint = "aa:bb:cc:dd:ee:ff"

private_key_path = "../keys/terraform/oci_terraform_api.pem"

#############################################
# Location
#############################################

region = "ap-mumbai-1"
```

Notice that no `var.` keyword is used.

Only actual values are assigned.

---

# 6. How Terraform Uses This File

Step 1

Terraform reads:

```
variables.tf
```

Terraform learns:

```
I require:

region

tenancy_ocid

user_ocid

fingerprint

private_key_path
```

Step 2

Terraform opens:

```
terraform.tfvars
```

Terraform finds:

```
region = "ap-mumbai-1"
```

Step 3

Terraform substitutes:

```hcl
provider "oci" {

region = var.region

}
```

becomes

```hcl
provider "oci" {

region = "ap-mumbai-1"

}
```

internally.

---

# 7. Variable Resolution Flow

```
variables.tf

↓

Variable Definitions

↓

terraform.tfvars

↓

Variable Values

↓

provider.tf

↓

Terraform Core

↓

OCI Provider

↓

OCI API
```

---

# 8. Environment Independence

Development

```hcl
region = "ap-mumbai-1"
```

Testing

```hcl
region = "ap-hyderabad-1"
```

Production

```hcl
region = "eu-frankfurt-1"
```

Only `terraform.tfvars` changes.

Terraform code remains unchanged.

---

# 9. Enterprise Folder Structure

```
terraform/

├── versions.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── locals.tf
├── outputs.tf
└── main.tf
```

Each file has a single responsibility.

---

# 10. Enterprise Best Practices

## Keep Values Separate from Code

Good

```hcl
provider "oci" {

region = var.region

}
```

Bad

```hcl
provider "oci" {

region = "ap-mumbai-1"

}
```

---

## Do Not Commit Secrets

Never commit:

- API Keys
- Passwords
- Private Keys
- Sensitive tfvars

Add to `.gitignore`

```
terraform.tfvars
```

---

## Different tfvars for Different Environments

```
dev.tfvars

test.tfvars

uat.tfvars

prod.tfvars
```

Deployment:

```bash
terraform apply -var-file=dev.tfvars
```

Production:

```bash
terraform apply -var-file=prod.tfvars
```

This is a common enterprise practice.

---

# 11. Variable Precedence

Terraform resolves variables in the following order
(highest precedence first):

1. CLI

```bash
terraform apply -var="region=ap-mumbai-1"
```

---

2. Variable File

```bash
terraform apply -var-file=dev.tfvars
```

---

3. Auto-loaded tfvars

```
terraform.tfvars

*.auto.tfvars
```

---

4. Environment Variables

```
TF_VAR_region=ap-mumbai-1
```

---

5. Default Value

Defined in

```
variables.tf
```

---

# 12. Common Mistakes

❌ Adding variable definitions here.

Wrong

```hcl
variable "region" {}
```

---

❌ Using `var.`

Wrong

```hcl
region = var.region
```

Correct

```hcl
region = "ap-mumbai-1"
```

---

❌ Committing secrets to Git.

---

❌ Hardcoding production values into Terraform code.

---

# 13. OCI Example

variables.tf

```hcl
variable "region" {
  type = string
}
```

terraform.tfvars

```hcl
region = "ap-mumbai-1"
```

provider.tf

```hcl
provider "oci" {
  region = var.region
}
```

Terraform automatically connects all three.

---

# 14. Azure Comparison

OCI

```hcl
region = "ap-mumbai-1"
```

Azure

```hcl
location = "Central India"
```

AWS

```hcl
region = "ap-south-1"
```

The concept is identical across cloud providers.

---

# 15. Interview Questions

## Easy

- What is terraform.tfvars?

- Why is it required?

---

## Medium

- What is the difference between variables.tf and terraform.tfvars?

- Can Terraform run without terraform.tfvars?

---

## Advanced

- Explain Terraform variable precedence.

- How do enterprise teams manage environment-specific values?

- Why should terraform.tfvars not be committed to Git?

---

# 16. Key Takeaways

- `variables.tf` defines the required inputs.
- `terraform.tfvars` supplies the actual values.
- This separation keeps Terraform reusable.
- Multiple environments can use different `.tfvars` files.
- Secrets should be protected and not committed to source control.

---

# 17. Revision Notes

Remember the sequence:

```
variables.tf

↓

"What information do I need?"

↓

terraform.tfvars

↓

"Here are the actual values."

↓

provider.tf

↓

"Use these values to connect to OCI."
```

---

# 18. Enterprise Insight

Enterprise teams rarely have a single `terraform.tfvars`.

A typical project contains:

```
terraform/

├── dev.tfvars
├── test.tfvars
├── uat.tfvars
├── prod.tfvars
└── variables.tf
```

The infrastructure code remains identical.

Only the variable files change.

This approach enables consistent deployments across multiple environments while reducing duplication and configuration drift.