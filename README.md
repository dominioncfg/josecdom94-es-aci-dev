# Elastic Search In Azure Container Instances

Currently is not easy to use Elastic Search in Azure Container instance, this is a docker image prepared for that, but only for testing purposes, you should consider other alternatives for production environments.

## Use with terraform

Here is an example of how you can use this image with terraform:

```terraform
resource "azurerm_container_group" "elasticSearchServer" {
  name                = "aci-elastic-dev-001"
  #Change to the correct location here:
  location            = azurerm_resource_group.rgServices.location
  #Change the resource group here:
  resource_group_name = azurerm_resource_group.rgServices.name
  ip_address_type     = "public"
  dns_name_label      = "qvaCar-elastic-dev"
  os_type             = "Linux"

  container {
    name   = "elastic-server"
    image  = "josecdom94/es-aci-dev:7.9.2"
    cpu    = "0.5"
    memory = "1.0"
    environment_variables = {     
      ES_JAVA_OPTS     = "-Xms512m -Xmx512m"
    }

    ports {
      port     = "9200"
      protocol = "TCP"
    }
  }
}
```
