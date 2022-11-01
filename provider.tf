# This code is auto generated and any changes will be lost if it is regenerated.

# -- Copyright: Copyright (c) 2020, 2022, Oracle and/or its affiliates.
# ---- Author : Andrew Hopkinson (Oracle Cloud Solutions A-Team)

terraform {
     required_version = ">= 0.12.0"
}

# ------ Connect to Provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

