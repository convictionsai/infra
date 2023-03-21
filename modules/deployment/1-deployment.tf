resource "kubernetes_deployment" "deployment" {
    wait_for_rollout = false

    metadata {

        name      = var.repo.name
        namespace = var.repo.namespace

        labels = {
            app = var.repo.type
        }

    }

    spec {
        replicas = var.repo.resources.replicas

        strategy {
            type = "RollingUpdate"

            rolling_update {
                max_surge       = 1
                max_unavailable = 1
            }
        }

        selector {
            match_labels = {
                app  = var.repo.name
                type = var.repo.type
            }
        }

        template {
            metadata {
                name = var.repo.name

                labels = {
                    app  = var.repo.name
                    type = var.repo.type
                }
            }

            spec {
                termination_grace_period_seconds = 0

                #                node_selector = {
                #                    "kubernetes.civo.com/civo-node-pool" = "services"
                #                }

                image_pull_secrets {
                    name = "ghcr"
                }

                container {
                    name  = var.repo.name
#                    image = "ghcr.io/convictionsai/${var.repo.name}:${var.repo.version}"
                    image = "ghcr.io/convictionsai/${var.repo.name}:latest"

                    image_pull_policy = "Always"

                    resources {
                        requests = {
                            cpu    = var.repo.resources.cpu
                            memory = var.repo.resources.memory
                        }
                        limits = {
                            cpu    = var.repo.resources.cpu
                            memory = var.repo.resources.memory
                        }
                    }

                    env {
                        name  = "PORT"
                        value = "8080"
                    }

                    port {
                        container_port = 8080
                    }
                    dynamic "env" {

                        for_each = var.environment_variables

                        content {
                            name  = env.key
                            value = env.value.value
                        }
                    }
                }
            }
        }
    }
}
