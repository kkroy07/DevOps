terraform {
  required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.17.0"
        }
  }
}

provider "azurerm" {
    subscription_id = "1955fd4c-850b-4dfd-9999-8e4aeed9be5b"
    tenant_id = "31357d13-e2bc-4d89-a7ae-6f584dd0a700"
    client_id = "5a4aa718-47aa-41ae-b0b9-0b0db47fdec1"
    client_secret = "lnq8Q~DAgvl~sBXyhM55djSIOP73WCd6YmiNncvc"
    features {
      
    }
  
}

resource "azurerm_service_plan" "kkrplan787878" {
  name                = "kkrplan787878"
  resource_group_name = "kkr-rg"
  location            = "North Europe"
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "kkrnewwebapp1234" {
  name                = "kkrnewwebapp1234"
  resource_group_name = "kkr-rg"
  location            = "North Europe"
  service_plan_id     = azurerm_service_plan.kkrplan787878.id

  site_config {
    always_on = false
    application_stack{
        current_stack="dotnet"
        dotnet_version="v6.0"
    }
  }
  depends_on = [
    azurerm_service_plan.kkrplan787878
  ]
}


resource "azurerm_mssql_server" "sqlserver45678345" {
  name                         = "sqlserver45678345"
  resource_group_name          = "kkr-rg"
  location                     = "North Europe"
  version                      = "12.0"
  administrator_login          = "sqluserkkr"
  administrator_login_password = "Azure@123"
}

resource "azurerm_mssql_database" "kkrappdb" {
  name           = "kkrappdb"
  server_id      = azurerm_mssql_server.sqlserver45678345.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"
  depends_on = [
    azurerm_mssql_server.sqlserver45678345
  ]
}

/*
Command to Execute terraform
terraform init
terraform plan -out main.tfplan
terraform apply "main.tfplan"
terraform destroy


*/
