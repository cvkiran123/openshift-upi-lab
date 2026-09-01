output "image_id" {
  value = oci_core_image.okd_custom_image.id
}

output "image_name" {
  value = oci_core_image.okd_custom_image.display_name
}