locals {
  images_bucket_name_prefix  = "anekdot-images"
  website_bucket_name_prefix = "anekdot-website"
}

resource "yandex_storage_bucket" "anekdot_images_bucket" {
  bucket     = "${local.images_bucket_name_prefix}-${local.folder_id}"
  access_key = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.secret_key
}

resource "yandex_storage_bucket" "anekdot_website_bucket" {
  bucket     = "${local.website_bucket_name_prefix}-${local.folder_id}"
  access_key = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.anekdot_api_sa_static_key.secret_key
}

output "anekdot_images_bucket" {
  value = yandex_storage_bucket.anekdot_images_bucket.bucket
}

output "anekdot_website_bucket" {
  value = yandex_storage_bucket.anekdot_website_bucket.bucket
}
