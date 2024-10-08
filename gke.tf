
#GKE
data "google_container_engine_versions" "gke_version" {
    location = var.region
    version_prefix = "1.29."
}

resource "google_container_cluster" "primary" {
    name = "${var.project_id}-gke"
    location = var.zone
    deletion_protection = false

    # Can't create cluster with no node pool, 
    # but we want to manage our own. create
    # small pool then immediately delete
    remove_default_node_pool = true
    initial_node_count = 1

    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name = google_container_cluster.primary.name
  location = var.zone
  cluster = google_container_cluster.primary.name

  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      #Below here are my additions - scopes needed to pull images from artifactory
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    labels = {
      env = var.project_id
    }

    #preemtible = true
    machine_type = "n1-standard-1"
    tags = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

