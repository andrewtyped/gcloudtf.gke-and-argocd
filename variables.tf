variable "project_id" {
    description = "GCloud project id"
}

variable "region" {
    description = "GCloud region"
}

variable "zone" {
    description = "GCloud zone"
}

variable "gke_username" {
    description = "gke username"
}

variable "gke_password" {
    description = "gke password"
    sensitive = true
}

variable "gke_num_nodes" {
    default = 2
    description = "number of gke nodes"
}