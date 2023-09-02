import json

def process_message(message):
   print("SNS message: "+ message)
   alarm_name = message.get("AlarmName")
   if not alarm_name:
      print("ignoring..")
      return
   if 'sleepy' in alarmname:
      print('host will shutdown')
   else:
      print('unknown alarm')
   return
   

def lambda_handler(event, context):
   print(event)
   sns_message = event['Records'][0]['Sns']['Message']
   result = process_message(sns_message)
   return result
