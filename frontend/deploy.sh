npm version patch
npm install
npm run build

aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive dist/ s3://${ANEKDOT_WEBSITE_BUCKET}
