resource "oci_core_instance" "compute" {

  for_each = var.nodes

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid

  display_name = each.key
  shape        = each.value.shape

  create_vnic_details {
    subnet_id = (
      each.key == "bastion"
      ? var.public_subnet_id : var.private_subnet_id
    )
    assign_public_ip          = each.value.assign_public_ip
    hostname_label            = each.value.hostname_label
    assign_private_dns_record = true
  }

  source_details {
    source_type             = "image"
    source_id               = var.coreos_image_ocid
    boot_volume_size_in_gbs = 100
  }

  metadata = {
    user_data = (
      each.key == "bastion"
      ? base64encode(jsonencode({
        ignition = {
          version = "3.2.0"
        }

        passwd = {
          users = [
            {
              name              = "core"
              sshAuthorizedKeys = [trimspace(file(var.ssh_public_key))]
            }
          ]
        }
      }))
      : base64encode(jsonencode({
        ignition = {
          version = "3.2.0"

          config = {
            merge = [
              {
                source = (
                  startswith(each.key, "master-")
                  ? format(
                    "http://%s:8080/master.ign",
                    var.bastion_private_ip
                  )
                  : format(
                    "http://%s:8080/worker.ign",
                    var.bastion_private_ip
                  )
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
    )
  }

  extended_metadata = {
    ignition_platform = "openstack"
  }

  shape_config {
    ocpus         = each.value.ocpus
    memory_in_gbs = each.value.memory_in_gbs
  }
}