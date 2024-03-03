resource "azurerm_resource_group" "app" {
  name     = var.resource_group_name
  location = "West US"
  tags = merge(var.tags, {
    Name = "${var.tags.owner}-rg"
  })
}

/*
resource "azurerm_storage_account" "this" {
  name                     = "gmappstorage"
  resource_group_name      = azurerm_resource_group.app.name
  location                 = azurerm_resource_group.app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = merge(var.tags, {
    Name = "${var.tags.owner}-sa"
  })
}

resource "azurerm_storage_container" "this" {
  name                  = "app-storage"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
*/

resource "azurerm_service_plan" "this" {
  name                = "app-service-plan"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location
  sku_name            = "B1"
  os_type             = "Linux"
  tags = merge(var.tags, {
    Name = "${var.tags.owner}-static-site"
    ENV  = "dev"
  })
}

resource "azurerm_linux_web_app" "this" {
  name                = "gm-test-app"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_resource_group.app.location
  service_plan_id     = azurerm_service_plan.this.id
  app_settings = {
    DBHOST = "${azurerm_mysql_flexible_server.default.name}"
    DBNAME = random_string.name.result
    DBPASS = random_password.password.result
  }
  site_config {
    vnet_route_all_enabled = true
  }
}

resource "azurerm_linux_web_app_slot" "this" {
  name                      = "gm-app-slot"
  app_service_id            = azurerm_linux_web_app.this.id
  virtual_network_subnet_id = azurerm_subnet.default.id
  site_config {}
}
/*
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = "gm-app-cdn-profile"
  resource_group_name = azurerm_resource_group.app.name
  sku_name            = "Standard_AzureFrontDoor"
  tags = merge(var.tags, {
    Name = "${var.tags.owner}-frontdoor-cdn-profile"
  })
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = "gmapp-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  enabled                  = true
  tags = merge(var.tags, {
    ENV = "dev"
  })
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = "gmapp-origingroup"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                           = "gmapp-origin"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.this.id
  enabled                        = true
  certificate_name_check_enabled = false
  host_name                      = "willwriteforfun.com"
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = "www.willwriteforfun.com"
  priority                       = 1
  weight                         = 1
}
*/
