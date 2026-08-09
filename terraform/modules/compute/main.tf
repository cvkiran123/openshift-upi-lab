resource "oci_core_instance" "compute" {

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid

  display_name = var.instance_name
  shape        = var.instance_shape

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
    hostname_label   = var.hostname_label
  }

  source_details {
    source_type = "image"
    source_id   = var.coreos_image_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }
}