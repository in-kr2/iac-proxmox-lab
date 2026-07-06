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
    insecure  = true # Käyttää self-signed-sertifikaattia.
}

resource "proxmox_virtual_environment_vm" "vm" {
    count               = var.instance_count
    name                = "cloned-vm-${count.index + 1}"
    node_name           = var.proxmox_node_name
    vm_id               = 200 + count.index
    clone {
        vm_id = "9000" # mallipohjan id
        full = true
    }
    cpu {
        cores = 2
    }
    memory {
        dedicated = 2048
    }
    disk {
        datastore_id = "local-lvm"
        interface = "scsi0"
        size = 10 # Gigatavua
        }

network_device {
        bridge = "vmbr0"
    }
    # Ei odoteta vierasagenttia ennen suorituksen valmistumista,
    # mikä estää Terraformin jumittumisen ensimmäisen käynnistyksen aikana
    agent {
        enabled = false
    }
    initialization {
        user_account {
            username = "vm_ubuntu"
            keys = [var.ssh_public_key]
            password = var.virtual_environment_root_password
        }
        ip_config{
            ipv4 {
                address = "192.168.0.${251 + count.index}/24"
                gateway = "192.168.0.1"
            }
        }
    }
}

# Luo Ansiblelle inventory.ini tiedoston automaattisesti
locals {
  vm_ips = [for vm in proxmox_virtual_environment_vm.vm :
    split("/", vm.initialization[0].ip_config[0].ipv4[0].address)[0]]
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    ips = local.vm_ips
  })
}
