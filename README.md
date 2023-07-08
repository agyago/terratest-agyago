# terratest-agyago

Module:
  - bootstrap = creating s3 bucket for terraform state files
  ``` 
  1. terraform init -backend=false
  2. terraform plan -out=tfplan -target=module.s3_bucketlist
  3. terraform apply tfplan
  4. change versions.tf.disable to versions.tf
  5. terraform init -backend-config=../backends3.env -force-copy
    initially you need to input 'initialkey.tfstate'
