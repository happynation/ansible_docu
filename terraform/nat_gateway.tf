# ELastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
}

# NAT gateway for private ip address
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.project_name}-vpc-NAT-gateway"
  }
}