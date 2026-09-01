/*
resource "oci_core_instance" "bootstrap" {

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E4.Flex"

  shape_config {
    ocpus         = 4
    memory_in_gbs = 16
  }

  display_name = "bootstrap"

  create_vnic_details {
    subnet_id        = var.private_subnet_id
    assign_public_ip = false
    hostname_label   = "bootstrap"
  }

  source_details {
    source_type = "image"
    source_id   = var.coreos_image_ocid
  }

  metadata = {
    user_data = base64encode(
      jsonencode({
        ignition = {
          version = "3.2.0"

          config = {
            merge = [
              {
                source = format(
                  "http://%s:8080/bootstrap.ign",
                  var.bastion_private_ip
                )
              }
            ]
          }
        }

        passwd = {
          users = [
            {
              name              = "core"
              sshAuthorizedKeys = [trimspace(file(var.ssh_public_key))]
            }
          ]
        }
      })
    )
  }

  extended_metadata = {
    ignition_platform = "openstack"
  }
}
*/