variable "keypair_name" {
  type = string
  description = "Name of the keypair"
}

variable "instance_name" {
  type = string
  description = "Virtual Machine name"
}

variable "instance_flavor" {
  type = string
  description = "Flavor of the Virtual Machine"
}

variable "openstack_image" {
  type = string
  description = "Image to be used within OpenStack"
  default = "Debian 12 - GARR"
}

variable "port_name" {
  type = string
  description = "Name of the port"
  default = "port_1"
}

variable "network_name" {
  type = string
  description = "Name of the network"
  default = "network_1"
}

variable "subnet_name" {
  type = string
  description = "Name of the subnet"
  default = "subnet_1"
}

variable "subnet_cidr" {
  type = string
  description = "Subnet CIDR"
}

variable "router_name" {
  type = string
  description = "Name of the router"
  default = "router_1"
}
