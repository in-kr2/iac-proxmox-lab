variable "virtual_environment_endpoint" {
    type        = string
    description = "Proxmox API endpoint"
}

variable "virtual_environment_ssh_username" {
    type        = string
}

variable "virtual_environment_api_token" {
    type        = string
    sensitive   = true
}
variable "virtual_environment_root_password" {
    type        = string
    sensitive   = true
}

variable "proxmox_node_name" {
    type        = string
}

variable "ssh_public_key" {
    type        = string
}
