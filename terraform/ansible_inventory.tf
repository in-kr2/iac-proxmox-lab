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
