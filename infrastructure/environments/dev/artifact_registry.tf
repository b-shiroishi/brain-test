# Backend用リポジトリ
module "backend_artifact_registry" {
  source = "../../modules/artifact_registry"

  repository_id = "web"
}

# Data Transfer用リポジトリ
module "data_transfer_artifact_registry" {
  source = "../../modules/artifact_registry"

  repository_id = "data-transfer"
}