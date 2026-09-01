resource "oci_objectstorage_bucket" "okd_images" {
  compartment_id = var.compartment_id
  name           = var.bucket_name
  access_type    = "NoPublicAccess"
  storage_tier   = "Standard"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
}

resource "oci_objectstorage_object" "okd_image" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
  bucket    = oci_objectstorage_bucket.okd_images.name
  object    = var.object_name      # The name of the object in the bucket
  source    = var.local_image_path # The local path to the image file to upload
}

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_id
}