module "storage" {
  source = "../../modules/storage"

  project_id  = var.project_id
  environment = var.environment
  region      = var.region
}