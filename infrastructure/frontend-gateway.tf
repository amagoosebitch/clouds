locals {
  website_gateway_name = "anekdot-frontend-gateway"
}

resource "yandex_api_gateway" "anekdot_frontend_gateway" {
  name      = local.website_gateway_name
  folder_id = local.folder_id
  spec      = file("../frontend/openapi.yaml")
}

output "anekdot_frontend_gateway_domain" {
  value = "https://${yandex_api_gateway.anekdot_frontend_gateway.domain}"
}
