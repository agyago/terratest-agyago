locals {
  vpc_cidr_block      = var.cidr_block
  public_subnet_count = 3
  private_subnet_count = 3
  public_subnet_bits  = 8
  private_subnet_bits = 8
}

data "aws_availability_zones" "available" {}