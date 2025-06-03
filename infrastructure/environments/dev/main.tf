terraform {
  required_version = "~> 1.6.0"  
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10.0" 
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.10.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "current" {}

data "google_project" "branubrain_fs" {
  project_id = var.project_id
}