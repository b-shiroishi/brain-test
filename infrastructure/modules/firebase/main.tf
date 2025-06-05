locals {
  project_id = "branubrain-fs"
}

data "google_project" "main" {
  project_id = local.project_id
}

# Firebase API有効化
resource "google_project_service" "firebase_apis" {
  for_each = toset([
    "firebase.googleapis.com",
    "firebasehosting.googleapis.com",
  ])
  
  project = data.google_project.main.project_id
  service = each.value

  disable_on_destroy = false
}

# Firebase プロジェクト有効化
resource "google_firebase_project" "main" {
  provider   = google-beta
  project    = data.google_project.main.project_id
  depends_on = [google_project_service.firebase_apis]
}

resource "random_id" "site_suffix" {
  byte_length = 4
}

resource "google_firebase_hosting_site" "main" {
  provider = google-beta
  project  = google_firebase_project.main.project
  site_id  = "${local.project_id}-${var.environment}-${random_id.site_suffix.hex}"
}