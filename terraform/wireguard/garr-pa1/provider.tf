# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  cloud = "openstack"
}
