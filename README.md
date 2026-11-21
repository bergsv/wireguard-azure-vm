# WireGuard Azure VM

This repository contains configurations and scripts for deploying WireGuard VPN on Azure Virtual Machines using HCL (HashiCorp Configuration Language).
The tutorial can be found here: [Establishing a VPN tunnel between Microsoft Azure and Fritz!Box with WireGuard](https://svenbergendahl.com/establishing-a-vpn-tunnel-between-microsoft-azure-and-fritzbox-with-wireguard/)

## Features

- Automated deployment of WireGuard VPN on Azure VMs
- Secure and private VPN connections
- Easy configuration and management

## Prerequisites

- Azure account
- Terraform installed
- Azure CLI installed

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/bergsv/wireguard-azure-vm.git
   cd wireguard-azure-vm
   ```

2. Authenticate with Azure CLI and select the subscription (the azurerm 4.x provider needs the subscription ID):
   ```bash
   az login
   export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
   ```

3. Create a `terraform.tfvars` file with your own values. It is ignored by git:
   ```hcl
   admin_password     = "<your password>"
   ssh_source_address = "<your public IP>/32"
   ```

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Plan the deployment:
   ```bash
   terraform plan
   ```

6. Apply the deployment:
   ```bash
   terraform apply
   ```

7. Copy `wg0.conf.example` to `/etc/wireguard/wg0.conf` on the VM and replace the keys, addresses and endpoint with the values from your Fritz!Box. Delete the `Allow_SSH` rule once the tunnel works.

## Configuration

You can customize the WireGuard configuration by modifying the HCL files in the repository. Refer to the [Terraform documentation](https://www.terraform.io/docs/) for more details on how to configure and manage your deployments.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any improvements or bug fixes.

## License

This project is licensed under the MIT License.
