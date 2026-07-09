terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.111.0" # Tällä hetkellä "latest" (2.7.2026)
    }
  }
}
