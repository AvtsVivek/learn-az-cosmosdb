# resource "random_integer" "ri" {
#   min = 10000
#   max = 99999
# }

resource "azurerm_cosmosdb_account" "acc" {
  name                = "${local.resource_name_prefix}-tfex-cosmos-account-${random_string.myrandom.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  # kind                = "MongoDB"
  # kind = ""

  enable_automatic_failover = true

  #   capabilities {
  #     name = "EnableAggregationPipeline"
  #   }

  #   capabilities {
  #     name = "mongoEnableDocLevelTTL"
  #   }

  #   capabilities {
  #     name = "MongoDBv3.4"
  #   }

  #   capabilities {
  #     name = "EnableMongo"
  #   }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  #   geo_location {
  #     location          = "eastus"
  #     failover_priority = 1
  #   }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "acc-sql-db" {
  name                = "${local.resource_name_prefix}-families-db-${random_string.myrandom.id}"
  resource_group_name = azurerm_cosmosdb_account.acc.resource_group_name
  account_name        = azurerm_cosmosdb_account.acc.name
}