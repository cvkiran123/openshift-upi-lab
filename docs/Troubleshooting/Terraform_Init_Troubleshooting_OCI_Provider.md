# Terraform `init` Troubleshooting – Oracle OCI Provider

**Date:** 29-Jul-2026

## Objective
Investigate why `terraform init` appeared to hang while installing the Oracle OCI provider during the OKD UPI on Oracle Cloud project.

## Environment

| Component | Value |
|---|---|
| OS | Ubuntu 24.04 |
| Terraform | 1.15.8 |
| Provider | oracle/oci v7.32.0 |

## Problem

Running:

```bash
terraform init
```

appeared to stop at:

```text
Initializing provider plugins...
- Finding oracle/oci versions matching "~> 7.22"...
- Installing oracle/oci v7.32.0...
```

## Investigation Timeline

### Step 1 – Verify provider download

```bash
find .terraform -type f
```

Provider binary existed under:

```text
.terraform/providers/registry.terraform.io/oracle/oci/7.32.0/linux_amd64/
```

### Step 2 – Verify provider size

```bash
ls -lh .terraform/providers/registry.terraform.io/oracle/oci/7.32.0/linux_amd64/
```

Result:

```text
245M terraform-provider-oci_v7.32.0
```

### Step 3 – Verify Terraform installation

Created a minimal project using the Random provider.

```bash
terraform init
```

Succeeded immediately, proving Terraform installation was healthy.

### Step 4 – Enable TRACE logging

```bash
TF_LOG=TRACE terraform init 2> init.log
```

Observed:
- Backend initialized
- Module initialized
- Registry contacted
- GitHub checksum downloaded
- Signature downloaded
- Provider ZIP requested

### Step 5 – Test GitHub download

```bash
wget https://github.com/oracle/terraform-provider-oci/releases/download/v7.32.0/terraform-provider-oci_7.32.0_linux_amd64.zip
```

Observed download speed:

- 150–320 KB/s
- ETA ~3 minutes

### Step 6 – Retry

```bash
rm -rf .terraform
rm -f .terraform.lock.hcl
time terraform init
```

Result:

```text
Terraform has been successfully initialized!

real    4m0.586s
user    0m4.336s
sys     0m3.206s
```

## Root Cause

The OCI provider (~245 MB) required several minutes to download over a slow connection. Terraform does not display download progress, making it appear to be frozen.

## Commands Used

```bash
terraform version
terraform init
terraform validate
find .terraform -type f
ls -lh .terraform/providers/registry.terraform.io/oracle/oci/7.32.0/linux_amd64/
TF_LOG=TRACE terraform init 2> init.log
tail -100 init.log
wget https://github.com/oracle/terraform-provider-oci/releases/download/v7.32.0/terraform-provider-oci_7.32.0_linux_amd64.zip
time terraform init
```

## Lessons Learned

- Verify assumptions before changing code.
- Use TRACE logs to isolate initialization delays.
- Test with a minimal Terraform project.
- Measure execution with `time`.
- Don't interrupt large provider downloads.

## STAR Interview Example

**Situation:** `terraform init` appeared to hang.

**Task:** Determine whether the issue was Terraform, OCI, network, or project configuration.

**Action:** Used TRACE logs, verified provider files, created a minimal project, tested direct download with `wget`, and measured execution time.

**Result:** Confirmed the delay was due to downloading a large provider over a slow network. No Terraform code changes were required.