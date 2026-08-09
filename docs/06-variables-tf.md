# Terraform Variables (variables.tf)

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

---

# 1. Purpose

Variables make Terraform configurations reusable, maintainable, and environment-independent.

Instead of hardcoding values inside Terraform code, variables define the inputs that Terraform expects.

Think of variables as the **public interface** of your Infrastructure as Code.

---

# 2. Why Do Variables Exist?

Suppose we hardcode the OCI region.

```hcl
provider "oci" {
  region = "ap-mumbai-1"
}
```

Tomorrow the company wants to deploy to:

- Frankfurt
- Tokyo
- Ashburn

Now the code must be edited.

This is not scalable.

Instead:

```hcl
provider "oci" {
  region = var.region
}
```

Now the code never changes.

Only the input value changes.

---

# 3. Problem Without Variables

Hardcoded configuration:

```hcl
cidr_block = "10.0.0.0/16"
```

Production requires:

```
172.16.0.0/16
```

The developer edits the code.

Result:

- Different code per environment
- Difficult maintenance
- Higher chance of mistakes

---

# 4. Solution With Variables

Terraform code:

```hcl
cidr_block = var.vcn_cidr
```

Development:

```
10.0.0.0/16
```

Production:

```
172.16.0.0/16
```

Only the variable value changes.

The Terraform code remains identical.

---

# 5. Variables as Function Parameters

Think like a software developer.

Java example:

```java
createVM(name, cpu, memory)
```

Terraform example:

```hcl
provider "oci" {
  region = var.region
}
```

The code defines what inputs it requires.

The caller supplies those values.

---

# 6. High-Level Architecture

```
Terraform Code

↓

variables.tf

↓

Input Values

↓

Provider

↓

OCI API

↓

Cloud Resources
```

---

# 7. Responsibility of variables.tf

variables.tf does **NOT** contain actual values.

Its responsibility is only to define:

- Variable Name
- Description
- Type
- Validation Rules
- Default Value (optional)
- Whether the value is sensitive

Think of it as a contract.

It tells Terraform:

> "These are the inputs required to run this project."

---

# 8. First Variable

Example:

```hcl
variable "region" {

  description = "OCI Region"

  type = string

}
```

Notice:

There is no value like:

```
ap-mumbai-1
```

That value comes later.

---

# 9. Anatomy of a Variable

Example:

```hcl
variable "region" {

  description = "OCI Region"

  type = string

  nullable = false

}
```

Explanation:

### variable

Declares a Terraform input variable.

---

### description

Explains the purpose of the variable.

Useful for documentation and team collaboration.

---

### type

Specifies the expected datatype.

Examples:

```hcl
type = string

type = number

type = bool

type = list(string)

type = map(string)

type = object(...)
```

Terraform validates the supplied value.

---

### nullable

Specifies whether the variable can be null.

Example:

```hcl
nullable = false
```

Terraform requires a value.

---

### default

Optional.

Example:

```hcl
default = "ap-mumbai-1"
```

If omitted,

Terraform expects the user to provide a value.

---

### sensitive

Marks confidential values.

Example:

```hcl
sensitive = true
```

Useful for:

- Passwords
- Tokens
- Secrets

Terraform hides these values in output.

---

# 10. Where Do Variable Values Come From?

Terraform supports multiple input sources.

Priority (highest to lowest):

1. CLI

```
terraform apply -var="region=ap-mumbai-1"
```

---

2. Variable File

```
terraform.tfvars
```

---

3. Auto-loaded tfvars files

```
*.auto.tfvars
```

---

4. Environment Variables

```
TF_VAR_region=ap-mumbai-1
```

---

5. Default Value

Defined inside variables.tf

---

# 11. Enterprise Variable Flow

```
variables.tf

↓

Defines Inputs

↓

terraform.tfvars

↓

Provides Values

↓

provider.tf

↓

Uses Values

↓

OCI Provider

↓

OCI API
```

Every file has one responsibility.

---

# 12. Variable Categories

As the project grows, variables should be grouped.

## Identity

- tenancy_ocid
- user_ocid

---

## Authentication

- fingerprint
- private_key_path

---

## Location

- region

---

## Networking

- vcn_cidr
- public_subnet_cidr
- private_subnet_cidr

---

## Compute

- instance_shape
- image_id
- boot_volume_size

---

## Storage

- block_volume_size

Grouping variables improves readability.

---

# 13. Enterprise Best Practices

✅ Every variable must have:

- Description
- Type

Prefer adding:

- nullable
- validation
- sensitive (if applicable)

Avoid:

- Unnecessary default values
- Generic names
- Hardcoded environment values

---

# 14. Common Mistakes

❌ Hardcoding values.

❌ Omitting descriptions.

❌ Using unclear names.

Bad

```hcl
variable "x" {}
```

Good

```hcl
variable "region" {}
```

❌ Putting secrets inside variables.tf.

❌ Confusing variables.tf with terraform.tfvars.

---

# 15. OCI Example

Instead of:

```hcl
provider "oci" {

  region = "ap-mumbai-1"

}
```

Use:

```hcl
provider "oci" {

  region = var.region

}
```

Now the provider becomes reusable.

---

# 16. Azure Comparison

Exactly the same concept.

OCI

```
region = var.region
```

Azure

```
location = var.location
```

AWS

```
region = var.region
```

Terraform variables are cloud-independent.

Only provider-specific field names differ.

---

# 17. Interview Questions

## Easy

- What are Terraform variables?
- Why are variables used?

---

## Medium

- Why shouldn't values be hardcoded?
- Explain the purpose of variables.tf.

---

## Advanced

- Explain the complete Terraform variable resolution order.
- How would you design variables for a reusable enterprise module?
- Why should variables.tf not contain secrets?

---

# 18. Key Takeaways

- variables.tf defines the input interface for Terraform.
- It does not store environment-specific values.
- Variables improve reusability and maintainability.
- Terraform supports multiple sources for variable values.
- Enterprise projects categorize variables and document every variable clearly.

---

# 19. Revision Notes

Remember the distinction:

**variables.tf**

> Defines **what information is required.**

**terraform.tfvars**

> Provides **the actual values.**

Think of it as:

Application Form

↓

Questions

↓

Applicant

↓

Answers

variables.tf = Questions

terraform.tfvars = Answers

---

# 20. Enterprise Insight

Enterprise teams treat Terraform modules like software libraries.

Just as a Java method defines parameters but does not contain the caller's values, a Terraform module defines variables but does not contain environment-specific values.

This separation allows the same infrastructure code to be deployed consistently across Development, Test, UAT, and Production by changing only the supplied variable values.