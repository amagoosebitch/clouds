from fastapi import FastAPI
from settings import create_settings
from ydb_client import YDBClient
from entities import InfoOutputDto, MessageOutputDto, CreateOutputDto, Message
import uvicorn

app = FastAPI()
settings = create_settings()

ydb_client = YDBClient()

replica_id: str = ydb_client.get_replica_str()


@app.get("/")
async def root():
    return {"description": "Анекдотельная!", "type": "api"}


@app.get("/api/info", response_model=InfoOutputDto)
async def server_info():
    return {"backend_version": settings.backend_version, "replica_id": replica_id}


@app.get("/api/messages", response_model=MessageOutputDto)
async def messages():
    items, response = await ydb_client.get_messages()
    return {"messages": items, "count": response.get("Count", 0)}


@app.post("/api/messages", response_model=CreateOutputDto)
async def add_message(msg: Message):
    name_id = await ydb_client.create_message(msg)
    return {"created_id": name_id, "replica_id": replica_id, "backend_version": settings.backend_version}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=settings.port)