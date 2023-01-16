# Анекдотельная
https://d5dvhk72jp2fseiqjk9c.apigw.yandexcloud.net - Прекрасный сервис, для того, чтобы делиться со всеми пользователями интернета своими любимыми анекдотами

# Инфраструктура
1. ```
   yc resource-manager folder list
   ```

2. ```
    export FOLDER_ID={folder_id из предыдущей комманды}
    ```
3. Проставить значения в `init.tf` переменными из облака

4. ```
    terrafrom init
    ```
   
5. ```
    terraform apply
    ```
   И остановить на создании бакетов
6.  ```
    ./startup.sh
    ```

7. Проставить следующие енвы: 
   ```
      API_SA_ID
      AWS_SECRET_ACCESS_KEY
      AWS_ACCESS_KEY_ID
      DOCUMENT_API_ENDPOINT
      ANEKDOT_API_REPOSITORY_NAME
      ANEKDOT_API_CONTAINER_ID
   ```
   Их можно найти в выводе скрипта и в `aws_private_key`
8. ```
   ./grant_permissions.sh
   ``` 
9. Проставить `API_SA_ID` и `ANEKDOT_API_CONTAINER_ID` в файлах `backend/openapi.yaml` и `frontend/openapi.yaml`
10.  создать gateway
   ```
    terraform apply -target=yandex_ydb_database_serverless.anekdot_api_gateway
    terraform apply -target=yandex_api_gateway.anekdot_frontend_gateway
   ```
   выставляем `ANEKDOT_API_GATEWAY`

11. проставить `ANEKDOT_WEBSITE_BUCKET` локально и в `frontent/openapi.yaml`

12. Создать бакеты командой 
   ```
   terraform apply -target=yandex_storage_bucket.anekdot_frontend_bucket
   ```
13. ```
    python3 ../backend/src/create_tables.py
    ```
   В папке `frontend/src/api.js` указать значение `ANEKDOT_API_GATEWAY`

14. ```
    cd ../backend && ./deploy.sh
    cd ../frontend && ./deploy.sh
    ```
