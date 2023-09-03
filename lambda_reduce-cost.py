import json
import boto3
import os

rds_cluster = os.environ['RDS_CLUSTER']
rds_param = { 'DBClusterIdentifier': rds_cluster }

def process_rds(message):
   try:
      rds = boto3.client('rds')
      if message == 'wake-up':
         print(f'{rds_cluster} starting...')
         return rds.start_db_cluster(**rds_param)
      elif message == 'stop':
         print(f'{rds_cluster} stopping...')
         return rds.stop_db_cluster(**rds_param)
   except:
      print('Error RDS not responding')

def process_message(message):
   print("SNS message: " + message)
   msg = json.loads(message)
   alarm_name = msg.get("AlarmName")
   if not alarm_name:
      print("ignoring..")
      return
   if 'sleepy' in alarm_name:
      print('ASG will terminate instances')
      process_rds('stop')
   elif 'wake-up' in alarm_name:
      print('ASG will add instance')
      process_rds('wake-up')
   else:
      print('unknown alarm')
   return
   

def lambda_handler(event, context):
   print(event)
   sns_message = event['Records'][0]['Sns']['Message']
   result = process_message(sns_message)
   return result
