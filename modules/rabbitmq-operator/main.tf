resource "null_resource" "kubectl" {

    provisioner "local-exec" {

        command = "kubectl --insecure-skip-tls-verify=true --server=\"${ var.server }\" --token=\"${ var.token }\" delete -f https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml; kubectl --insecure-skip-tls-verify=true --server=\"${ var.server }\" --token=\"${ var.token }\" apply -f https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"

    }

}