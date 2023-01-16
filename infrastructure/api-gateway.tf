locals {
  api_gateway_name = "anekdot-api-gateway"
}

resource "yandex_api_gateway" "anekdot_api_gateway" {
  name      = local.api_gateway_name
  folder_id = local.folder_id
  spec      = file("../backend/openapi.yaml")
}

output "anekdot_api_gateway_domain" {
  value = "https://${yandex_api_gateway.anekdot_api_gateway.domain}"
}
