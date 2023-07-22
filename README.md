# terratest-agyago

Module:
- bootstrap/s3 = creating s3 bucket for terraform state files
  ``` 
  1. terraform init -backend=false
  2. terraform plan -out=tfplan -target=module.s3_bucketlist
  3. terraform apply tfplan
  4. change versions.tf.disable to versions.tf
  5. terraform init -backend-config=../backends3.env -backend-config=keyhole.env -force-copy ```

- bootstrap/iam = creating user and admin/readonly group account
  ```
  1. adding additional users is easy
  2. removing user in any group, remove every user in the group. it needs terraform plan/apply again to refresh/readd users in the group ```

- VPC = Creating network
   * a VPC
   * public subnet - [internet gateway] - has access and is accessible from the internet
   * private subnet - [nat gw ] - can use internet access but not accessible from outside(internet)
