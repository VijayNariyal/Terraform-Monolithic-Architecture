variable "load_balancer" {
  description = "this is load balancer variable file"
  type = map(object({
    lb_name             = string
    location            = string
    resource_group_name = string
    pip_name            = string
    frontend_ip_configuration = list(object({
      frontend_name = string
    }))
    lbbackend_name = string
    lbrule_name    = string
    protocol       = string
    frontend_port  = number
    backend_port   = number
  }))
}
