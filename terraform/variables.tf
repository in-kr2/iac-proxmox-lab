variable "virtual_environment_endpoint" {
    description = "Proxmox API endpoint"
    type        = string
}

variable "virtual_environment_ssh_username" {
    description = "SSH käyttäjänimi"
    type        = string
}

variable "virtual_environment_api_token" {
    description = "Salainen API avain"
    type        = string
    sensitive   = true
}
variable "virtual_environment_root_password" {
    description = "Virtuaalisen ympäristön pääkäyttäjän salasana"
    type        = string
    sensitive   = true
}

variable "proxmox_node_name" {
    type        = string
}

variable "ssh_public_key" {
    description = "Julkinen SSH avain"
    type        = string
}
variable "instance_count" {
    description = "Luotavien virtuaalikoneiden määrä"
    type        = number
    default     = 1
}
