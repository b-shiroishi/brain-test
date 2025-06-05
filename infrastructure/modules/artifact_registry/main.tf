locals {
  project_id = "branubrain-fs"
  region = "asia-northeast1"
}

# Artifact Registry API有効化
resource "google_project_service" "artifact_registry_api" {
  service = "artifactregistry.googleapis.com"
  
  disable_dependent_services = false
  disable_on_destroy         = false
}

# Artifact Registryリポジトリ
resource "google_artifact_registry_repository" "main" {
  location      = local.region
  repository_id = var.repository_id
  format        = "DOCKER"

  depends_on = [google_project_service.artifact_registry_api]
}