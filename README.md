# lxcterramox
## create you LXC Containers with Terraform in Proxmox
## first of all create user for Terraform in Proxmox and give it all permissions to create or delete resources 
### you can name your user anything you want
### you can also do all of this steps in the browser at ```https://<proxmox-ip>:8006```
```
consol
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add <USER>@pve --password <PASSWORD>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```
## edit main.tf with your user and password values
```
consol
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}
provider "proxmox" {
    pm_api_url = "https://proxmox-server01.example.com:8006/api2/json"
    pm_user = "<USER>@pve"
    pm_password = "<PASSWORD>"
}
```
## now start and create you lxc containers
```
terraform init
```
