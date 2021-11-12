terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}

provider "proxmox" {
    pm_api_url = "https://<Proxmox-IP>:8006/api2/json"
    pm_debug = true
    pm_user = "<USER>@pve"
    pm_password = "<PASSWORD>"
}

######### LXC container

resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     =  "instance-${ count.index + 1 }"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  password     = "changeme"  # this password is for user login the default user is root
  unprivileged = true
  start        = true
  count        = 3        # how many resources you want to create (you can change it)
  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp" # you also can put "192.168.1.1${count.index + 1}/24" instead dhcp 
  }
}
