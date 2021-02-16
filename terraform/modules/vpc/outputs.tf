output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "subnets_default_ids" {
  value = aws_subnet.public.*.id
}

output "subnets_default_cidrs" {
  value = aws_subnet.public.*.cidr_block
}
