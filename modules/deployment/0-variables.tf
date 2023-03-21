variable "repo" {

    type = object({

        name      = string
        type      = string
        version   = string
        namespace = string

        resources = object({

            replicas = number
            cpu      = string
            memory   = string

        })

        networking = object({

            ingress = object({

                hostname = string
                path     = string

            })

            ports = list(object({

                name          = string
                containerPort = number
                targetPort    = number
                protocol      = string

            }))

        })

    })

}

variable "environment_variables" {

    #    type = object({
    #
    #        scope = string
    #        value = string
    #
    #    })

}
