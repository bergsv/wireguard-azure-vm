provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group_homelab" {
  name     = "rg-homelab"
  location = "germanywestcentral"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "vnet-homelab"
  resource_group_name = azurerm_resource_group.resource_group_homelab.name
  location            = azurerm_resource_group.resource_group_homelab.location
  address_space       = ["192.168.220.0/24"]
}

resource "azurerm_subnet" "subnet_homelab" {
  depends_on           = [azurerm_virtual_network.virtual_network]
  name                 = "subnet-homelab"
  resource_group_name  = azurerm_resource_group.resource_group_homelab.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["192.168.220.0/24"]
}

# Define a static public IP for WireGuard
resource "azurerm_public_ip" "public_ip_wireguard" {
  name                = "pip-wireguard"
  resource_group_name = azurerm_resource_group.resource_group_homelab.name
  location            = azurerm_resource_group.resource_group_homelab.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Security Group for WireGuard VM
resource "azurerm_network_security_group" "nsg_wireguard" {
  name                = "nsg-wireguard"
  resource_group_name = azurerm_resource_group.resource_group_homelab.name
  location            = azurerm_resource_group.resource_group_homelab.location

/* PLEASE DELETE THE SSH RULE AFTER SET UP */

  security_rule {
    name                       = "Allow_SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    # Please change source address to your own IP address
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

/* DELETE THE SECURITY RULE BLOCK AFTER SET UP */

  security_rule {
    name                       = "Allow_WireGuard"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "51820"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Network Interface for WireGuard with Security Group association
resource "azurerm_network_interface" "nic_wireguard" {
  name                  = "nic-wireguard"
  resource_group_name   = azurerm_resource_group.resource_group_homelab.name
  location              = azurerm_resource_group.resource_group_homelab.location
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_homelab.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_wireguard.id
  }
}

# Associate the NIC with the Network Security Group
resource "azurerm_network_interface_security_group_association" "nsg_association_wireguard" {
  network_interface_id      = azurerm_network_interface.nic_wireguard.id
  network_security_group_id = azurerm_network_security_group.nsg_wireguard.id
}

# Create a Linux VM for WireGuard
resource "azurerm_linux_virtual_machine" "vm_wireguard" {
  name                            = "vm-wireguard"
  resource_group_name             = azurerm_resource_group.resource_group_homelab.name
  location                        = azurerm_resource_group.resource_group_homelab.location
  size                            = "Standard_B2ts_v2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_wireguard.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}