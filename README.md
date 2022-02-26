# Elastic Search In Azure Container Instances

Currently is not easy to use Elastic Search in Azure Container instance, this is a docker image prepared for that, but only for testing purposes, you should consider other alternatives for production environments.

## Download the Image

The image can be downloaded directly from [docker hub](https://hub.docker.com/r/josecdom94/es-aci-dev).

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

## Run With Docker

Although it doesn’t make much sense to use docker locally since is not much different from the original elastic search, you can still use docker locally:

```bash
docker run -dt --name elastic-search -p 9200:9200 josecdom94/es-aci-dev:7.9.2
```

After a while you can check that the status of the cluster is green by typing this URL in the browser <http://localhost:9200/_cluster/health> and get something similar to this:

```bash
{
    "cluster_name": "docker-cluster",
    "status": "green",
    "timed_out": false,
    "number_of_nodes": 1,
    "number_of_data_nodes": 1,
    "active_primary_shards": 0,
    "active_shards": 0,
    "relocating_shards": 0,
    "initializing_shards": 0,
    "unassigned_shards": 0,
    "delayed_unassigned_shards": 0,
    "number_of_pending_tasks": 0,
    "number_of_in_flight_fetch": 0,
    "task_max_waiting_in_queue_millis": 0,
    "active_shards_percent_as_number": 100.0
}
```

## How does it works

The magic is just setting an environment variable **discovery.type=single-node** before starting the cluster, but bear in mind that this is a single node cluster and is not recommended for production environments. You can check the docker file for more details.

## Build Status

[![Build And Publish](https://github.com/dominioncfg/josecdom94-es-aci-dev/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/dominioncfg/josecdom94-es-aci-dev/actions/workflows/docker-image.yml)
