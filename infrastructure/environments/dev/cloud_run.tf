module "cloud_run" {
  source = "../../modules/cloud_run"

  project_id = var.project_id
  region = var.region
}