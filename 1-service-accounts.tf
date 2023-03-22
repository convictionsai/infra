resource "kubernetes_service_account" "cicd" {
    metadata {
        name      = "cicd"
        namespace = "convictionsai"
    }
}

resource "kubernetes_cluster_role" "cicd" {
    metadata {
        name = "cicd"
    }

    rule {
        api_groups = [
            ""
        ]
        resources  = [
            "componentstatuses"
        ]
        verbs      = [
            "list"
        ]
    }

    rule {
        api_groups = [
            ""
        ]
        resources  = [
            "componentstatuses"
        ]
        verbs      = [
            "list"
        ]
    }

    rule {
        api_groups = [
            "networking.k8s.io"
        ]
        resources  = [
            "ingresses"
        ]
        verbs      = [
            "get",
            "create",
            "update",
            "delete"
        ]
    }

    rule {
        api_groups = [
            ""
        ]
        resources  = [
            "services"
        ]
        verbs      = [
            "get",
            "create",
            "update",
            "delete"
        ]
    }

    rule {
        api_groups = [
            "apps"
        ]
        resources  = [
            "deployments"
        ]
        verbs      = [
            "get",
            "create",
            "update",
            "delete"
        ]
    }
}

resource "kubernetes_cluster_role_binding" "cicd" {
    metadata {
        name = "cicd"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "cicd"
    }

    subject {
        kind      = "ServiceAccount"
        name      = "cicd"
        namespace = "convictionsai"

    }
}
