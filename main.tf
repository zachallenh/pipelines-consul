# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  cloud {
    workspaces {
      name = "pipelines-consul"
      project = "sandbox"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.77.0"
    }
  }

  required_version = ">= 1.1.0"
}



data "tfe_outputs" "cluster" {
  organization = var.organization
  workspace    = var.cluster_workspace
}

resource "terraform_data" "output" {
  input = data.tfe_outputs.cluster
}


# # Retrieve GKE cluster information
# provider "google" {
#   project = "hc-a5efd9dda7c242dd9e8ffe9136a"#data.tfe_outputs.cluster.values.project_id
#   region  = "us-central1"#data.tfe_outputs.cluster.values.region
# }

# data "google_client_config" "default" {}

# provider "kubernetes" {
#   host                   = "https://${data.tfe_outputs.cluster.values.host}"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = data.tfe_outputs.cluster.values.cluster_ca_certificate

# }

# provider "helm" {
#   kubernetes {
#     host                   = data.tfe_outputs.cluster.values.host
#     token                  = data.google_client_config.default.access_token
#     cluster_ca_certificate = data.tfe_outputs.cluster.values.cluster_ca_certificate

#   }
# }
