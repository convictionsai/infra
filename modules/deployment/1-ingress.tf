#
# https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-ingressroute
#
resource "kubernetes_manifest" "traefik-router" {

    manifest = {

        apiVersion = "traefik.containo.us/v1alpha1"
        kind       = "IngressRoute"

        metadata = {
            namespace = var.repo.namespace
            name      = var.repo.name
        }

        spec = {
            entryPoints = [
                "https"
            ]

            routes = [
                {
                    kind     = "Rule"
                    match    = "Host(`${ var.repo.networking.ingress.hostname }`) && PathPrefix(`${ var.repo.networking.ingress.path }`)"
                    #                    middlewares = [
                    #                        {
                    #                            name      = "api-strip-prefix"
                    #                            namespace = var.repo.namespace
                    #                        }
                    #                    ]
                    services = [
                        {
                            name      = var.repo.name
                            namespace = var.repo.namespace
                            port      = var.repo.networking.ports[ 0 ].containerPort
                        }
                    ]
                }
            ]

            tls = {
                secretName = "tls-traefik"
                options    = {
                    name      = "traefik-tls-options"
                    namespace = "default"
                }
            }
        }
    }
}
