resource "oci_dns_zone" "zone" {

  compartment_id = var.compartment_ocid
  name           = var.zone_name
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"

  view_id = oci_dns_view.okd_private_view.id #private view for the zone
}

resource "oci_dns_rrset" "api" {

  zone_name_or_id = oci_dns_zone.zone.id
  domain          = "api.${var.cluster_name}.${var.zone_name}"
  rtype           = "A"
  items {
    domain = "api.${var.cluster_name}.${var.zone_name}"
    rdata  = var.load_balancer_ip
    rtype  = "A"
    ttl    = 300
  }
}


resource "oci_dns_rrset" "api_int" {

  zone_name_or_id = oci_dns_zone.zone.id
  domain          = "api-int.${var.cluster_name}.${var.zone_name}"
  rtype           = "A"
  items {
    domain = "api-int.${var.cluster_name}.${var.zone_name}"
    rdata  = var.load_balancer_ip
    rtype  = "A"
    ttl    = 300
  }
}

resource "oci_dns_rrset" "apps" {

  zone_name_or_id = oci_dns_zone.zone.id
  domain          = "*.apps.${var.cluster_name}.${var.zone_name}"
  rtype           = "A"
  items {
    domain = "*.apps.${var.cluster_name}.${var.zone_name}"
    rdata  = var.load_balancer_ip
    rtype  = "A"
    ttl    = 300
  }
}

resource "oci_dns_view" "okd_private_view" {
  compartment_id = var.compartment_ocid

  display_name = "okd-private-view"
  scope        = "PRIVATE"
}

resource "oci_dns_resolver" "okd_resolver" {
  resolver_id = var.resolver_id

  attached_views {
    view_id = oci_dns_view.okd_private_view.id
  }
}


