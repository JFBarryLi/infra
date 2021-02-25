resource "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.azs[count.index]
  cidr_block              = "10.1.0.0/22"

  tags = {
    Name      = "Default subnet for ${var.azs[count.index]}."
    ManagedBy = "terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id= aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.azs)

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.*.id[count.index]
}
