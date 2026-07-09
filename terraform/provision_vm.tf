resource "proxmox_virtual_environment_vm" "vm" {
  count     = var.instance_count
  name      = "cloned-vm-${count.index + 1}"
  node_name = var.proxmox_node_name
  vm_id     = 200 + count.index
  clone {
    vm_id = "9000" # mallipohjan id
    full  = true
  }
  cpu {
    cores = 2
  }
  memory {
    dedicated = 2048
  }
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 10 # Gigatavua
  }

  network_device {
    bridge = "vmbr0"
  }
  # Ei odoteta vierasagenttia ennen suorituksen valmistumista
  agent {
    enabled = false
  }
  initialization {
    user_account {
      username = "vm_ubuntu"
      keys     = [var.ssh_public_key]
      password = var.virtual_environment_root_password
    }
    ip_config {
      ipv4 {
        address = "192.168.0.${251 + count.index}/24"
        gateway = "192.168.0.1"
      }
    }
  }
}
