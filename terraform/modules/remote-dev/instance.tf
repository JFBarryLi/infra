resource "aws_instance" "this" {
  ami                    = "ami-089b5711e63812c2a"
  instance_type          = "t2.micro"
  key_name               = "remote_dev"
  vpc_security_group_ids = [aws_security_group.this.id]
}
