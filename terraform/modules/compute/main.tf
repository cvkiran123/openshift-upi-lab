resource "oci_core_instance" "compute" {
  for_each = var.nodes

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid

  display_name = each.key
  shape        = each.value.shape

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = each.value.assign_public_ip
    hostname_label   = each.value.hostname_label
  }

  source_details {
    source_type = "image"
    source_id   = var.coreos_image_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  shape_config {
    ocpus         = each.value.ocpus
    memory_in_gbs = each.value.memory_in_gbs
  }
}