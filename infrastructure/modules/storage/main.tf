resource "google_storage_bucket" "main" {
  name     = "${var.project_id}-${var.environment}-storage"
  location = var.region
  
  # バージョニングを有効化
  versioning {
    enabled = true
  }
  
  # ライフサイクル管理
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
  
  # パブリックアクセスを防止
  public_access_prevention = "enforced"
  
  # 均一なバケットレベルアクセス
  uniform_bucket_level_access = true
  
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}