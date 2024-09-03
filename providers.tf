provider "google" {
  # 'My First Project'
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}