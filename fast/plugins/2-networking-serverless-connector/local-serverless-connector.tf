/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# tfdoc:file:description Serverless Connector resources.

locals {
  plugin_sc_subnets = {
    dev-primary = {
      for k, v in module.dev-spoke-vpc-serverless.subnets : k => v.name
    }
    prod-primary = {
      for k, v in module.prod-spoke-vpc-serverless.subnets : k => v.name
    }
    dev-secondary = {
      for k, v in module.dev-spoke-vpc-serverless-secondary.subnets : k => v.name
    }
    prod-secondary = {
      for k, v in module.prod-spoke-vpc-serverless-secondary.subnets : k => v.name
    }
  }
}

module "dev-spoke-vpc-serverless" {
  source     = "../../../modules/net-vpc"
  project_id = module.dev-spoke-project.project_id
  name       = module.dev-spoke-vpc.name
  vpc_create = false
  subnets = [{
    name          = "access-connector"
    description   = "VPC Serverless Connector for the primary region."
    ip_cidr_range = var.serverless_connector_config.dev-primary.ip_cidr_range
    region        = var.regions.primary
    flow_logs_config = {
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_1_MIN"
      metadata             = "INCLUDE_ALL_METADATA"
      filter               = null

    }
  }]
}

module "prod-spoke-vpc-serverless" {
  source     = "../../../modules/net-vpc"
  project_id = module.prod-spoke-project.project_id
  name       = module.prod-spoke-vpc.name
  vpc_create = false
  subnets = [{
    name          = "access-connector"
    description   = "VPC Serverless Connector for the primary region."
    ip_cidr_range = var.serverless_connector_config.prod-primary.ip_cidr_range
    region        = var.regions.primary
    flow_logs_config = {
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_1_MIN"
      metadata             = "INCLUDE_ALL_METADATA"
      filter               = null

    }
  }]
}

resource "google_vpc_access_connector" "dev-primary" {
  count   = var.serverless_connector_config.dev-primary == null ? 0 : 1
  project = module.dev-spoke-project.project_id
  region  = var.regions.primary
  name    = "access-connector-${local.region_shortnames[var.regions.primary]}"
  subnet {
    name = local.plugin_sc_subnets.dev-primary["${var.regions.primary}/access-connector"]
  }
  machine_type   = var.serverless_connector_config.dev-primary.machine_type
  max_instances  = var.serverless_connector_config.dev-primary.instances.max
  max_throughput = var.serverless_connector_config.dev-primary.throughput.max
  min_instances  = var.serverless_connector_config.dev-primary.instances.min
  min_throughput = var.serverless_connector_config.dev-primary.throughput.min
}

resource "google_vpc_access_connector" "prod-primary" {
  count   = var.serverless_connector_config.prod-primary == null ? 0 : 1
  project = module.prod-spoke-project.project_id
  region  = var.regions.primary
  name    = "access-connector-${local.region_shortnames[var.regions.primary]}"
  subnet {
    name = local.plugin_sc_subnets.prod-primary["${var.regions.primary}/access-connector"]
  }
  machine_type   = var.serverless_connector_config.prod-primary.machine_type
  max_instances  = var.serverless_connector_config.prod-primary.instances.max
  max_throughput = var.serverless_connector_config.prod-primary.throughput.max
  min_instances  = var.serverless_connector_config.prod-primary.instances.min
  min_throughput = var.serverless_connector_config.prod-primary.throughput.min
}


module "dev-spoke-vpc-serverless-secondary" {
  source     = "../../../modules/net-vpc"
  project_id = module.dev-spoke-project.project_id
  name       = module.dev-spoke-vpc.name
  vpc_create = false
  subnets = [{
    name          = "access-connector"
    description   = "VPC Serverless Connector for the secondary region."
    ip_cidr_range = var.serverless_connector_config.dev-secondary.ip_cidr_range
    region        = var.regions.secondary
    flow_logs_config = {
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_1_MIN"
      metadata             = "INCLUDE_ALL_METADATA"
      filter               = null

    }
  }]
}

module "prod-spoke-vpc-serverless-secondary" {
  source     = "../../../modules/net-vpc"
  project_id = module.prod-spoke-project.project_id
  name       = module.prod-spoke-vpc.name
  vpc_create = false
  subnets = [{
    name          = "access-connector"
    description   = "VPC Serverless Connector for the secondary region."
    ip_cidr_range = var.serverless_connector_config.prod-secondary.ip_cidr_range
    region        = var.regions.secondary
    flow_logs_config = {
      flow_sampling        = 0.5
      aggregation_interval = "INTERVAL_1_MIN"
      metadata             = "INCLUDE_ALL_METADATA"
      filter               = null

    }
  }]
}

resource "google_vpc_access_connector" "dev-secondary" {
  count   = var.serverless_connector_config.dev-secondary == null ? 0 : 1
  project = module.dev-spoke-project.project_id
  region  = var.regions.secondary
  name    = "access-connector-${local.region_shortnames[var.regions.secondary]}"
  subnet {
    name = local.plugin_sc_subnets.dev-secondary["${var.regions.secondary}/access-connector"]
  }
  machine_type   = var.serverless_connector_config.dev-secondary.machine_type
  max_instances  = var.serverless_connector_config.dev-secondary.instances.max
  max_throughput = var.serverless_connector_config.dev-secondary.throughput.max
  min_instances  = var.serverless_connector_config.dev-secondary.instances.min
  min_throughput = var.serverless_connector_config.dev-secondary.throughput.min
}

resource "google_vpc_access_connector" "prod-secondary" {
  count   = var.serverless_connector_config.prod-secondary == null ? 0 : 1
  project = module.prod-spoke-project.project_id
  region  = var.regions.secondary
  name    = "access-connector-${local.region_shortnames[var.regions.secondary]}"
  subnet {
    name = local.plugin_sc_subnets.prod-secondary["${var.regions.secondary}/access-connector"]
  }
  machine_type   = var.serverless_connector_config.prod-secondary.machine_type
  max_instances  = var.serverless_connector_config.prod-secondary.instances.max
  max_throughput = var.serverless_connector_config.prod-secondary.throughput.max
  min_instances  = var.serverless_connector_config.prod-secondary.instances.min
  min_throughput = var.serverless_connector_config.prod-secondary.throughput.min
}