# WireGuard Azure VM

This repository contains configurations and scripts for deploying WireGuard VPN on Azure Virtual Machines using HCL (HashiCorp Configuration Language).
The tutorial could be found here 

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

2. Authenticate with Azure CLI:
   ```bash
   az login
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the deployment:
   ```bash
   terraform apply
   ```

## Configuration

You can customize the WireGuard configuration by modifying the HCL files in the repository. Refer to the [Terraform documentation](https://www.terraform.io/docs/) for more details on how to configure and manage your deployments.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
