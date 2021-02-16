resource "aws_default_subnet" "public" {
  count = length(var.azs)

  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name      = "Default subnet for ${var.azs[count.index]}."
    ManagedBy = "terraform"
  }
}
