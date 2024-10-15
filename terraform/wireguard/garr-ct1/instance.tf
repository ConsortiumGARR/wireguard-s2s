data "openstack_images_image_v2" "debian" {
  name = var.openstack_image
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "openstack_networking_port_v2" "port_1" {
  name = var.port_name
  network_id = openstack_networking_network_v2.network_1.id
  port_security_enabled = false

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_1.id
  }
}

resource "openstack_compute_instance_v2" "tf_instance" {
  name = var.instance_name
  image_id = data.openstack_images_image_v2.debian.id
  flavor_name = var.instance_flavor
  key_pair = var.keypair_name
  user_data = "${file("userdata.sh")}"

  network {
    port = openstack_networking_port_v2.port_1.id
  }
}

#Associate the floating ip to tf_instance
resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id = openstack_networking_port_v2.port_1.id

  depends_on = [
    openstack_compute_instance_v2.tf_instance,
    openstack_networking_floatingip_v2.floatip_1
  ]
}
