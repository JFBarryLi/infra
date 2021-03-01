output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "subnet_public_ids" {
  value = aws_subnet.public.*.id
}

output "subnet_public_cidrs" {
  value = aws_subnet.public.*.cidr_block
}
