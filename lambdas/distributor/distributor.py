import json
import boto3
import csv
import os
from collections import defaultdict

s3 = boto3.client('s3')
sqs = boto3.client('sqs')

QUEUE_URL = os.environ.get('QUEUE_URL')
BUCKET_NAME = os.environ.get('S3_BUCKET_NAME')
FILE_NAME = os.environ.get('S3_FILE_NAME')

def lambda_handler(event, context):
    grouped_data = defaultdict(list)
    total_received = 0

    # Dane z S3
    s3Response = s3.get_object(Bucket=BUCKET_NAME, Key=FILE_NAME)
    data = s3Response['Body'].read().decode('utf-8').splitlines()
    records = csv.reader(data)
    headers = next(records)

    for row in records:
        if len(row) < 4:
            continue
        location_id = row[1]
        grouped_data[location_id].append({
            'sensor_id': row[0],
            'location_id': row[1],
            'temperature': float(row[2]),
            'timestamp': row[3]
        })

    # Zwróć pogrupowane dane
    output = []
    for location_id, recs in grouped_data.items():
        output.append({
            'location_id': location_id,
            'records': recs
        })

    return {
        "grouped_data": output
    }
