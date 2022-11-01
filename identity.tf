
# ------ Root Compartment
locals {
    DeploymentCompartment_id              = var.compartment_ocid
}

output "DeploymentCompartmentId" {
    value = local.DeploymentCompartment_id
}
