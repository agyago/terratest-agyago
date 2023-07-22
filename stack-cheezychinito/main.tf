module "init_vpc" {
    source = "../modules/VPC"
    cidr_block = var.cidr_block
    count_number = var.count_number
    priv_count = var.priv_count
    pub_count = var.pub_count
}