terraform {
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = ">=0.111.0" # Tällä hetkellä "latest" (2.7.2026)
        }
    }
}

provider "proxmox" {
    endpoint  = var.virtual_environment_endpoint
    api_token = var.virtual_environment_api_token
    insecure  = true
}

resource "proxmox_virtual_environment_vm" "vm" {
    name                = "cloned-vm"
    node_name           = var.proxmox_node_name
    vm_id               = 200
    clone {
        vm_id = "9000" # templaten id
        full = true
    }
    cpu {
        cores = 2
    }
    memory {
        dedicated = 2048
    }
    # disk hoituu automaattisesti, ei tarvitse erikseen
    network_device {
        bridge = "vmbr0"
    }
    agent {
    enabled = false # ei odota vierasagenttia ennen terraform apply:ta
    }
    initialization {
        user_account {
            username = "vm_ubuntu"
            keys = [var.ssh_public_key]
            password = var.virtual_environment_root_password
        }
        ip_config{
            ipv4 {
                address = "dhcp"
            }
        }
    }
}

