resource "aws_instance" "this" {
  count = var.ec2_on

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "remote_dev"
  vpc_security_group_ids = [aws_security_group.this.id]
}
