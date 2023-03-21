resource "kubernetes_service" "service" {
    metadata {
        name      = var.repo.name
        namespace = var.repo.namespace

        labels = {
            app = var.repo.name
        }
    }

    spec {
        selector = {
            app = var.repo.name
        }
        port {
            name        = "http"
            port        = 8080
            target_port = 8080
            protocol    = "TCP"
        }
    }
}
