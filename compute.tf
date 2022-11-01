
# image_source 
# ------ Get List Images
data "oci_core_images" "Okit_I_1667345258260Images" {
    compartment_id           = var.compartment_ocid
    operating_system         = "Oracle Linux"
    operating_system_version = "8"
    shape                    = "VM.Standard.E3.Flex"
}
locals {
    Okit_I_1667345258260_image_id = data.oci_core_images.Okit_I_1667345258260Images.images[0]["id"]
}

# ------ Create Instance
resource "oci_core_instance" "Okit_I_1667345258260" {
    # Required
    compartment_id      = local.DeploymentCompartment_id
    shape               = "VM.Standard.E3.Flex"
    # Optional
    display_name        = "vm1"
    availability_domain = data.oci_identity_availability_domains.AvailabilityDomains.availability_domains["1" - 1]["name"]
    create_vnic_details {
        # Required
        subnet_id        = local.Okit_S_1667345114470_id
        # Optional
        assign_public_ip = true
        display_name     = "okitin009 Vnic"
        hostname_label   = "vm1"
        skip_source_dest_check = false
        freeform_tags    = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-5170f5e1-1935-4441-bf02-94926cc06b8c"}
    }
    metadata = {
        user_data           = base64encode("#! /bin/bash\nsudo setenforce 0\nsudo yum clean all\n#sudo yum -y update\nsudo yum -y install httpd\nsudo systemctl start httpd\nsudo systemctl enable httpd\nsudo firewall-cmd --permanent --zone=public --add-service=http\nsudo firewall-cmd --permanent --zone=public --add-service=https\nsudo firewall-cmd --reload\nsudo -s \ncat <<EOF > /var/www/html/index.html\n<!DOCTYPE html>\n<html lang=\"pt-br\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>OCI DEMO</title>\n</head>\n\n<body style=\"background-color:black;\">\n    <center>  \n    \n    <h1 style=\"color:white\"> OCI Cloud $(hostname -f)</h1> \n            <h2 style=\"color:white\"> Hello from OCI Cloud!!!! &#x270C; </h2>\n            <hr>\n            <img src=\"https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/axxrh2rs3lmm/b/bucket-demo/o/oracle_weboracle_web.jpgrc24-redbull-wing.jpeg\" alt=\"sucess\">\n    </center>    \n</body>\n</html>\nEOF")
    }
    shape_config {
        #Optional
        memory_in_gbs = "16"
        ocpus = "1"
    }
    source_details {
        # Required
        source_id               = local.Okit_I_1667345258260_image_id
        source_type             = "image"
        # Optional
        boot_volume_size_in_gbs = "50"
#        kms_key_id              = 
    }
    preserve_boot_volume = false
    freeform_tags              = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-5170f5e1-1935-4441-bf02-94926cc06b8c"}
}

locals {
    Okit_I_1667345258260_id            = oci_core_instance.Okit_I_1667345258260.id
    Okit_I_1667345258260_public_ip     = oci_core_instance.Okit_I_1667345258260.public_ip
    Okit_I_1667345258260_private_ip    = oci_core_instance.Okit_I_1667345258260.private_ip
    Okit_I_1667345258260_display_name    = oci_core_instance.Okit_I_1667345258260.display_name
}

output "Okit_I_1667345258260PublicIP" {
    value = [local.Okit_I_1667345258260_display_name, local.Okit_I_1667345258260_public_ip]
}

output "Okit_I_1667345258260PrivateIP" {
    value = [local.Okit_I_1667345258260_display_name, local.Okit_I_1667345258260_private_ip]
}

# ------ Create Block Storage Attachments

# ------ Create VNic Attachments

