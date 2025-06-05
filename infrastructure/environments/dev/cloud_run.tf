module "backend_cloud_run" {
  source = "../../modules/cloud_run"

  cloud_run_name = "web-dev"
  cloud_run_image_url = "asia-northeast1-docker.pkg.dev/branubrain-fs/dev/backend"
}

module "data_transfer_cloud_run" {
  source = "../../modules/cloud_run"

  cloud_run_name = "data-transfer-dev"
  cloud_run_image_url = "asia-northeast1-docker.pkg.dev/branubrain-fs/dev/data-transfer"
}