# wireguard-s2s

This repository provides an automated solution to deploy a WireGuard VPN in a
site-to-site (S2S) mode. The infrastructure for the VPN endpoints is managed using
Terraform, and the VPN configuration and setup are automated using Ansible. The setup
allows secure and seamless communication between two or more remote networks.

Please do note that this repo is mainly based on GARR Cloud, showing an example using
Catania and Palermo regions, but it can be applied on other scenarios.

> [!IMPORTANT]
> Port security group must be disabled on VMs. Handle firewall rules directly on the
> VMs.

Additional info on a wireguard site to site deployment can be found
[here](https://www.procustodibus.com/blog/2020/12/wireguard-site-to-site-config/).

## Prerequisites

- Ansible
- Terraform
- Cloud credentials file if using terraform on GARR Cloud

## Terraform

> [!NOTE]
> If you are not using GARR Cloud (or OpenStack), skip terraform part

1. CD into each region and execute a `terraform init` that will install the provider
2. Pasted downloaded `clouds.yaml` (Cloud credentials file)
3. Create a `terraform.tfvars` starting from the example (`terraform.tfvars.example`)

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Edit tfvars as needed
4. Execute terraform

```bash
terraform plan
... If all is good for you ...
terraform apply
```

Repeat for the other host.

## Ansible

> [!WARNING]
> A set of IPTable rules will be applied. Please check ansible/playbook.yml before
> running ansible.

1. Install requirements.yml

```bash
cd ansible
ansible-galaxy install -r requirements.yml
```

2. Create an inventory file starting from the example

```bash
cd inventories/vpns
cp hosts.ini.example hosts.ini
```

3. In hosts.ini fill `ansible_host` vars
4. Rename, if necessary, host names. If you do it, please apply the same name to folder
   inside `hosts_vars`.
5. In each hosts vars (e.g. ansible/host_vars/wireguard-ct/wireguard-ct.yml) `replace VM
   Settings` vars based on your configuration.
6. Change other variables if necessary (check
   <https://github.com/githubixx/ansible-role-wireguard>)

> [!TIP]
> If you don't want NAT remove statements in wireguard_postup and wireguard_postdown.

7. Deploy

```bash
./deploy.sh
```

Check that handshake is successful using wg command on both end.

```bash
root@wg-pa:~# wg
interface: wg0
  public key: **********
  private key: (hidden)
  listening port: 51820
  fwmark: 0x162e

peer: **********
  endpoint: **********:15685
  allowed ips: 10.252.1.2/32, 192.168.168.0/24
  latest handshake: 1 minute, 27 seconds ago
  transfer: 7.33 KiB received, 5.92 KiB sent
  persistent keepalive: every 15 seconds
```

## Contributing

Contributions are welcome! If you find any issues or would like to add new features,
feel free to submit a pull request.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE License. See the LICENSE
file for details.

## Credits

To @githubixx for the [ansible
role](https://github.com/githubixx/ansible-role-wireguard) that ease the installation
and setup of wireguard.
