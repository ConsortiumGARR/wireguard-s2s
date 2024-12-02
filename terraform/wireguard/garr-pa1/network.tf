resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "floating-ip"
}

data "openstack_networking_network_v2" "floating_ip" {
  name = "floating-ip"
}

resource "openstack_networking_network_v2" "network_1" {
  name = var.network_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name = var.subnet_name
  network_id = openstack_networking_network_v2.network_1.id
  cidr = var.subnet_cidr
  dns_nameservers = var.subnet_dns_nameservers
  ip_version = 4
}

resource "openstack_networking_router_v2" "router_1" {
  name = var.router_name
  external_network_id = data.openstack_networking_network_v2.floating_ip.id
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router_1.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
}
