module "firebase" {
  source      = "../../modules/firebase"
  project_id  = var.project_id
  environment = var.environment
}