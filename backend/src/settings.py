from pydantic import BaseSettings, Field
from functools import cache


class BackendSettings(BaseSettings):
	db_region_name: str = Field("ru-central1", env="DB_REGION_NAME")
	db_endpoint_url: str = Field("", env="DOCUMENT_API_ENDPOINT")
	aws_private_key: str = Field("", env="AWS_SECRET_ACCESS_KEY")
	aws_access_key_id: str = Field("", env="AWS_ACCESS_KEY_ID")
	backend_version: str = Field("Unknown", env="APP_VERSION")
	port: int = Field(8080, env="PORT")


@cache
def create_settings():
	return BackendSettings()
