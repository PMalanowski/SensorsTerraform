import json

def lambda_handler(event, context):
    if not event:
        return {
            'statusCode': 400,
            'body': json.dumps('Brak danych wejsciowych')
        }
    records = event['records']
    
    # Obliczanie średniej temperatury
    total_temp = 0
    count = len(records)
    
    for record in records:
        total_temp += record['temperature']
    
    average_temperature = total_temp / count if count > 0 else 0

    return {
        'location_id': event['location_id'],
        'average_temperature': average_temperature
    }
