variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "cloud_run_service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "branubrain-fs-dev"
}

variable "cloud_run_image_url" {
  description = "Container image URL"
  type        = string
  default     = "asia-northeast1-docker.pkg.dev/branubrain-fs/branubrain-fs-dev/backend-dev"
}

variable "cloud_run_container_port" {
  description = "Container port"
  type        = string
  default     = "8000"
}

variable "allow_unauthenticated" {
  description = "Allow unauthenticated access"
  type        = bool
  default     = false
}

variable "max_scale" {
  description = "Maximum number of instances"
  type        = string
  default     = "10"
}

variable "cpu_limit" {
  description = "CPU limit"
  type        = string
  default     = "2000m"
}

variable "memory_limit" {
  description = "Memory limit"
  type        = string
  default     = "1Gi"
}

variable "env_vars" {
  description = "Environment variables"
  type        = map(string)
  default     = {}
}

variable "service_account_roles" {
  description = "Roles to assign to the service account"
  type        = list(string)
  default     = []
}