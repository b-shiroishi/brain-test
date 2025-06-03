locals {
  enabled_apis = [
    "run.googleapis.com",                   
    "containerregistry.googleapis.com",     
    "artifactregistry.googleapis.com",   
  ]
}

# API有効化
resource "google_project_service" "cloud_run_apis" {
  for_each = toset(local.enabled_apis)
  
  service = each.key
  
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_artifact_registry_repository" "main" {
  location      = var.region
  repository_id = var.cloud_run_service_name
  description   = "Docker repository for ${var.cloud_run_service_name}"
  format        = "DOCKER"

  depends_on = [google_project_service.cloud_run_apis]
}

# サービスアカウント作成
resource "google_service_account" "cloud_run_sa" {
  account_id   = "${var.cloud_run_service_name}"
  display_name = "Cloud Run Service Account for ${var.cloud_run_service_name}"
  description  = "Service account for Cloud Run service ${var.cloud_run_service_name}"
}

# Cloud Run サービス
resource "google_cloud_run_service" "main" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_scale
        "run.googleapis.com/execution-environment" = "gen2"
      }
    }

    spec {
      service_account_name = google_service_account.cloud_run_sa.email
      
      containers {
        image = var.cloud_run_image_url != "" ? var.cloud_run_image_url : "gcr.io/cloudrun/hello"
        
        ports {
          container_port = var.cloud_run_container_port
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }

        resources {
          limits = {
            cpu    = var.cpu_limit
            memory = var.memory_limit
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.cloud_run_apis]
}

# IAM設定
resource "google_cloud_run_service_iam_member" "public_access" {
  count = var.allow_unauthenticated ? 1 : 0
  
  service  = google_cloud_run_service.main.name
  location = google_cloud_run_service.main.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# サービスアカウントに必要な権限付与
resource "google_project_iam_member" "cloud_run_sa_permissions" {
  for_each = toset(var.service_account_roles)
  
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}