resource "azurerm_storage_account" "example" {
  name                     = "functionsapptestsa0010102"
  resource_group_name      = "RSGRCU1XXXXP01"
  location                 = "centralus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-test-service-plan-test01"
  location            = "centralus"
  resource_group_name = "RSGRCU1XXXXP01"
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "example" {
  name                       = "test-azure-functions"
  location                   = "centralus"
  resource_group_name        = "RSGRCU1XXXXP01"
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "linux"
}

provider azurerm {
  version = "1.44.0"
}
