
# ------ Create Dhcp Options
# ------- Update VCN Default DHCP Option
resource "oci_core_default_dhcp_options" "Okit_DO_1667345083897" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1667345083892_default_dhcp_options_id
    options    {
        type  = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }
    options    {
        type  = "SearchDomain"
        search_domain_names      = ["okitvcn003.oraclevcn.com"]
    }
    # Optional
    display_name   = "okitdo006"
    freeform_tags  = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-62713068-f202-4b35-a0aa-8f6b39c35dad"}
}

locals {
    Okit_DO_1667345083897_id = oci_core_default_dhcp_options.Okit_DO_1667345083897.id
    }


# ------ Create Internet Gateway
resource "oci_core_internet_gateway" "Okit_IG_1667345151534" {
    # Required
    compartment_id = local.DeploymentCompartment_id
    vcn_id         = local.Okit_VCN_1667345083892_id
    # Optional
    enabled        = true
    display_name   = "igw1"
    freeform_tags  = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-38a8ad32-d6e6-4191-a635-6c5bb759ec71"}
}

locals {
    Okit_IG_1667345151534_id = oci_core_internet_gateway.Okit_IG_1667345151534.id
}


# ------ Create Route Table
# ------- Update VCN Default Route Table
resource "oci_core_default_route_table" "Okit_RT_1667345083895" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1667345083892_default_route_table_id
    route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = "0.0.0.0/0"
        network_entity_id = local.Okit_IG_1667345151534_id
    }
    # Optional
    display_name   = "rt-git"
    freeform_tags  = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-75c49e16-3bbc-4189-935d-e416f7e742a1"}
}

locals {
    Okit_RT_1667345083895_id = oci_core_default_route_table.Okit_RT_1667345083895.id
    }


# ------ Create Security List
# ------- Update VCN Default Security List
resource "oci_core_default_security_list" "Okit_SL_1667345083896" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1667345083892_default_security_list_id
    egress_security_rules {
        # Required
        protocol    = "all"
        destination = "0.0.0.0/0"
        # Optional
        destination_type  = "CIDR_BLOCK"
    }
    ingress_security_rules {
        # Required
        protocol    = "6"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
        tcp_options {
            min = "22"
            max = "22"
        }
    }
    ingress_security_rules {
        # Required
        protocol    = "1"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
        icmp_options {
            type = "3"
            code = "4"
        }
    }
    ingress_security_rules {
        # Required
        protocol    = "1"
        source      = "10.0.0.0/16"
        # Optional
        source_type  = "CIDR_BLOCK"
        icmp_options {
            type = "3"
        }
    }
    ingress_security_rules {
        # Required
        protocol    = "all"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
    }
    # Optional
    display_name   = "nsl-git"
    freeform_tags  = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-51f532dc-20c6-4689-a869-0a08a70d678f"}
}

locals {
    Okit_SL_1667345083896_id = oci_core_default_security_list.Okit_SL_1667345083896.id
}


# ------ Create Subnet
# ---- Create Public Subnet
resource "oci_core_subnet" "Okit_S_1667345114470" {
    # Required
    compartment_id             = local.DeploymentCompartment_id
    vcn_id                     = local.Okit_VCN_1667345083892_id
    cidr_block                 = "10.0.0.0/24"
    # Optional
    display_name               = "public"
    dns_label                  = "public"
    security_list_ids          = [local.Okit_SL_1667345083896_id]
    route_table_id             = local.Okit_RT_1667345083895_id
    prohibit_public_ip_on_vnic = false
    freeform_tags              = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-1f3c7abb-2f1f-456b-bf95-23805ef9a25b"}
}

locals {
    Okit_S_1667345114470_id              = oci_core_subnet.Okit_S_1667345114470.id
    Okit_S_1667345114470_domain_name     = oci_core_subnet.Okit_S_1667345114470.subnet_domain_name
}


# ------ Create Virtual Cloud Network
resource "oci_core_vcn" "Okit_VCN_1667345083892" {
    # Required
    compartment_id = local.DeploymentCompartment_id
    cidr_blocks    = ["10.0.0.0/16"]
    # Optional
    dns_label      = "github"
    display_name   = "github"
    freeform_tags  = {"okit_version": "0.40.0", "okit_model_id": "okit-model-4db8195b-6f6f-4760-876e-4f0b3a01378d", "okit_reference": "okit-fe323a8d-ed0e-4671-b0ba-de7140216577"}
    is_ipv6enabled  = false
}

locals {
    Okit_VCN_1667345083892_id                       = oci_core_vcn.Okit_VCN_1667345083892.id
    Okit_VCN_1667345083892_dhcp_options_id          = oci_core_vcn.Okit_VCN_1667345083892.default_dhcp_options_id
    Okit_VCN_1667345083892_domain_name              = oci_core_vcn.Okit_VCN_1667345083892.vcn_domain_name
    Okit_VCN_1667345083892_default_dhcp_options_id  = oci_core_vcn.Okit_VCN_1667345083892.default_dhcp_options_id
    Okit_VCN_1667345083892_default_security_list_id = oci_core_vcn.Okit_VCN_1667345083892.default_security_list_id
    Okit_VCN_1667345083892_default_route_table_id   = oci_core_vcn.Okit_VCN_1667345083892.default_route_table_id
}

