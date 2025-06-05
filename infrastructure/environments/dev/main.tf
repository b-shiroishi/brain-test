locals {
  project_id = "branubrain-fs"
  region = "asia-northeast1"
}

terraform {
  required_version = "~> 1.6.0"

  backend "gcs" {
    bucket = "branubrain-fs-terraform-state"
    prefix = "environments/dev"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }
  }
}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}