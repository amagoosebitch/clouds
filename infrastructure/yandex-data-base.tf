locals {
  database_name = "anekdot-database"
}

resource "yandex_ydb_database_serverless" "anekdot-database" {
  name      = local.database_name
  folder_id = local.folder_id
}

output "anekdot-database_document_api_endpoint" {
  value = yandex_ydb_database_serverless.anekdot-database.document_api_endpoint
}

output "anekdot-database_path" {
  value = yandex_ydb_database_serverless.anekdot-database.database_path
}
