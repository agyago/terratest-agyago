module "s3_bucketlist" {
    source = "../modules/bootstrap/s3"
    backend_bucket = var.buckety
    dynamic_table = var.dyna_table
}

module "iam_users" {
    source = "../modules/bootstrap/iam"
    admin_names = var.admin_names
    read_names  = var.read_names
    #local_group_policy = var.local_group_policy
}