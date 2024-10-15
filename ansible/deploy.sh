#!/bin/bash
ansible-playbook -i inventories/vpns/hosts.ini playbook.yml "$@"
