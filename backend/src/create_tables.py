import boto3

from settings import create_settings

settings = create_settings()


def create_tables(client):

    client.create_table(
        TableName='replica',
        KeySchema=[
            {
                'AttributeName': 'key',
                'KeyType': 'HASH'
            },
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'key',
                'AttributeType': 'N'
            },
            {
                'AttributeName': 'value',
                'AttributeType': 'N'
            },
        ]
    )
    client.create_table(
        TableName='messages',
        KeySchema=[
            {
                'AttributeName': 'message_id',
                'KeyType': 'HASH'
            },
            {
                'AttributeName': 'author',
                'KeyType': 'RANGE'
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'message_id',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'message',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'author',
                'AttributeType': 'S'
            },
        ]
    )


def add_replica(client):
    table = client.Table('replica')
    table.put_item(
        Item={
            'key': 0,
            'value': 1,
        }
    )
    return table


if __name__ == '__main__':
    ydb_client = boto3.resource('dynamodb',
                                region_name=settings.db_region_name,
                                endpoint_url=settings.db_endpoint_url,
                                aws_access_key_id=settings.aws_access_key_id,
                                aws_secret_access_key=settings.aws_private_key)
    create_tables(ydb_client)
    replica_table = add_replica(ydb_client)
    messages_table = ydb_client.Table('messages')

    print("Table(replica) status:", replica_table.table_status)
    print("Table(messages) status:", messages_table.table_status)

