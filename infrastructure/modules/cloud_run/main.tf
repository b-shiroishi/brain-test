locals {
  enabled_apis = [
    "run.googleapis.com",                   
    "containerregistry.googleapis.com",     
  ]
  
  project_id = "branubrain-fs"
  region = "asia-northeast1"
  container_port = "8000"
  allow_unauthenticated = false
  max_scale = "10"
  cpu_limit = "2000m"
  memory_limit = "1Gi"
}

resource "google_project_service" "cloud_run_apis" {
  for_each = toset(local.enabled_apis)
  
  service = each.key
  
  disable_dependent_services = false
  disable_on_destroy         = false
}

# Cloud Run サービス
resource "google_cloud_run_service" "main" {
  name     = var.cloud_run_name
  location = local.region

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = local.max_scale
        "run.googleapis.com/execution-environment" = "gen2"
      }
    }

    spec {
      service_account_name = "branubrain-fs@branubrain-fs.iam.gserviceaccount.com"
      
      containers {
        image = "gcr.io/cloudrun/hello"
        
        ports {
          container_port = local.container_port
        }

        resources {
          limits = {
            cpu    = local.cpu_limit
            memory = local.memory_limit
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.cloud_run_apis]
}

# IAM設定
resource "google_cloud_run_service_iam_member" "public_access" {
  count = local.allow_unauthenticated ? 1 : 0
  
  service  = google_cloud_run_service.main.name
  location = google_cloud_run_service.main.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}