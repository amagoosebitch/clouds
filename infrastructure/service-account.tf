locals {
  service_account_name_prefix = "anekdot-service-acc"
}

resource "yandex_iam_service_account" "anekdot_api_sa" {
  name        = "${local.service_account_name_prefix}-${local.folder_id}"
  description = "Service account to call anekdot container and anekdot-database"
}

resource "yandex_iam_service_account_static_access_key" "anekdot_api_sa_static_key" {
  service_account_id = yandex_iam_service_account.anekdot_api_sa.id
}

output "anekdot_api_sa_id" {
  value = yandex_iam_service_account.anekdot_api_sa.id
}

output "aws_access_key_id" {
  value = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.access_key
}

output "aws_private_key" {
  value = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.secret_key
  sensitive = true
}
