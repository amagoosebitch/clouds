#!/bin/sh
set -x
terraform apply -target=yandex_ydb_database_serverless.anekdot_database
terraform apply -target=yandex_iam_service_account.anekdot_api_sa
terraform apply -target=yandex_container_registry.default
terraform apply -target=yandex_container_repository.anekdot_api_repository
yc container registry configure-docker
yc sls container create --name anekdot-api-container --folder-id ${FOLDER_ID}
terraform output -raw aws_private_key > aws_private_key
