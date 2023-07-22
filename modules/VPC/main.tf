
# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a public subnet
resource "aws_subnet" "public" {
  #count             = var.count_number
  count         = var.pub_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(local.vpc_cidr_block, local.public_subnet_bits, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
}

# Create a route table for the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.gw.id
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public" {
  count             = var.count_number
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create a private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count         = var.priv_count
  #count             = var.count_number
  cidr_block        = cidrsubnet(local.vpc_cidr_block, local.private_subnet_bits, count.index + var.pub_count)
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
}

# Create a route table for the private subnet
resource "aws_route_table" "private" {
  count   = var.count_number
  vpc_id = aws_vpc.main.id
}

# Create a route to the NAT Gateway for internet access in the private subnet
resource "aws_route" "private_internet" {
  count             = var.count_number
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

# Associate the private subnet with the private route table
resource "aws_route_table_association" "private" {
  count             = var.count_number
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  count = var.count_number
  vpc = true
}

# Create a NAT Gateway in the public subnet
resource "aws_nat_gateway" "main" {
  count             = var.count_number
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
}

#resource "aws_vpc_dhcp_options" "dhcp" {
#  domain_name = "var.domain_name"
#}

#resource "aws_vpc_dhcp_options_association" "dhcp" {
#  vpc_id          = aws_vpc.main.id
#  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
#}

# Assign the VPC's DHCP options
#resource "aws_vpc" "main" {
  # ...
 # dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
#}
