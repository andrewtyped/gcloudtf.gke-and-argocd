output "region" {
    value = var.region
    description = "GCloud region"
}

output "zone" {
    value = var.zone
    description = "GCloud zone"
}

output "project_id" {
  value = var.project_id
  description = "GCloud project"
}

output "k8s_cluster_name" {
    value = google_container_cluster.primary.name
    description = "GKE cluster name"
}

output "k8s_cluster_host" {
    value = google_container_cluster.primary.endpoint
    description = "GKE Cluster Host"
}