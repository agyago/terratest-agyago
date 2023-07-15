locals {
  vpc_cidr_block      = var.cidr_block
  public_cidr_bits  = 24
  private_cidr_bits = 24
}

data "aws_availability_zones" "available" {}