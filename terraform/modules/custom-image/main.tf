resource "oci_core_image" "okd_custom_image" {
  compartment_id = var.compartment_ocid
  display_name   = var.display_name
  launch_mode    = "PARAVIRTUALIZED"

  image_source_details {
    source_type       = "objectStorageTuple"
    source_image_type = "QCOW2"
    #source_uri               = "https://objectstorage.${var.region}.oraclecloud.com/n/${var.object_storage_namespace}/b/${var.bucket_name}/o/${var.object_name}"
    namespace_name           = var.object_storage_namespace
    bucket_name              = var.bucket_name
    object_name              = var.object_name
    operating_system         = "CentOS Linux"
    operating_system_version = "10.0.20251103-0"
  }
}

resource "oci_core_shape_management" "compatible_shapes" {
  for_each = toset([for node in var.nodes : node.shape])

  compartment_id = var.compartment_ocid
  image_id       = oci_core_image.okd_custom_image.id
  shape_name     = each.value
}