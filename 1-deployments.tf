module "deployment-frontend-app" {

    source = "./modules/deployment"

    repo = {
        type      = "frontend"
        namespace = "convictionsai"
        name      = "app"
        version   = "0.0.6"
        resources = {
            replicas = 1
            cpu      = "500m"
            memory   = "512Mi"
        }
        networking = {
            ports = [
                {
                    name          = "http"
                    containerPort = 8080
                    targetPort    = 8080
                    protocol      = "TCP"

                }
            ]
            ingress = {
                hostname = "app.convictions.ai"
                path     = "/"
            }
        }
    }

    environment_variables = {

    }
}
