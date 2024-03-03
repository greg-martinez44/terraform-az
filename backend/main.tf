terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {

  }
}

data "azurerm_resource_group" "azure_tf" {
  name = "azure_tf"
}

resource "azurerm_storage_account" "this" {
  name                     = "gmtfbackend"
  resource_group_name      = data.azurerm_resource_group.azure_tf.name
  location                 = data.azurerm_resource_group.azure_tf.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Name     = "tfbackend"
    owner-dl = "greg-martinez44@outlook.com"
    owner    = "Greg Martinez"
  }
}

resource "azurerm_storage_container" "this" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
