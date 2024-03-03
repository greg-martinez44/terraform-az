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
  name                     = "tfbackend"
  resource_group_name      = data.azurerm_resource_group.azure_tf.name
  location                 = data.azurerm_resource_group.azure_tf.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
