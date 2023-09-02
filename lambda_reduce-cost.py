import json

def process_message(message):
   print("SNS message: "+ message)
   

def lambda_handler(event, context):
   print(event)
   sns_message = event['Records'][0]['Sns']['Message']
   result = process_message(sns_message)
   return result
