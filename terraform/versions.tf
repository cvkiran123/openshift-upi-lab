terraform {
  required_version = "~> 1.13"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.22"
    }
  }
}
