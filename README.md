# terratest-agyago

Module:
  - bootstrap = creating s3 bucket for terraform state files
  ``` 
  1. terraform init -backend=false
  2. terraform plan -out=tfplan -target=module.s3_bucketlist
  3. terraform apply tfplan
  4. terraform init -reconfigure \
     -backend-config="bucket=bucketybuckbuckagyago1234567890" \
     -backend-config="key=initialkey.tfstate" \
     -backend-config="dynamodb_table=tableybuckbuckagyago1234567890" \
     -backend-config=region="us-east-1"
