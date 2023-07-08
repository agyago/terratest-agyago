data "terraform_remote_state" "s3_bucketlist" {
    backend = "s3"

    config = {
        bucket = var.buckety
        key = "initialkey.tfstate"
        dynamodb_table = var.dyna_table
        region = var.provider_var
    }
}

terraform {
  backend "s3" {}
}
