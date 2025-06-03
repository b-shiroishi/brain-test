# 既存プロジェクトを参照
data "google_project" "main" {
  project_id = var.project_id
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

# Hostingサイト作成
resource "google_firebase_hosting_site" "main" {
  provider = google-beta
  project  = google_firebase_project.main.project
  site_id  = "${var.project_id}-${var.environment}"
}