import json


def handler(event, context):
    print("Received event:", json.dumps(event))
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": "Hello from API Gateway!", "input": event}),
    }
