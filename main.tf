module "s3_bucketlist" {
    source = "./modules/bootstrap"
    backend_bucket = "bucketybuckbuckagyago1234567890"
    dynamic_table = "tableybuckbuckagyago1234567890"
}

terraform {
  backend "s3" {
  }
}