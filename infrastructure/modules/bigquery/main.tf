locals {
  project_id = "branubrain-fs"
  region = "asia-northeast1"
  dataset_owners = ["s.shiroishi@branu.jp", "branubrain-fs@branubrain-fs.iam.gserviceaccount.com"]
}

# BigQuery API有効化
resource "google_project_service" "bigquery_api" {
  service = "bigquery.googleapis.com"
  
  disable_dependent_services = false
  disable_on_destroy         = false
}

# BigQueryデータセット
resource "google_bigquery_dataset" "main" {
  dataset_id = "datamart_${var.environment}"
  location   = local.region
  
  description = "Product data dataset for branubrain-fs"
  
  # データセットの有効期限（オプション）
  default_table_expiration_ms = 3600000  # 1時間（必要に応じて調整）
  
  # アクセス制御
  dynamic "access" {
    for_each = local.dataset_owners
    content {
      role          = "OWNER"
      user_by_email = access.value
    }
  }
  
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
  
  depends_on = [google_project_service.bigquery_api]
}
