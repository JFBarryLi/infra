data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "template_file" "mount_efs" {
  template = file("${path.module}/mount_efs.sh")

  vars = {
    efs_id = aws_efs_file_system.this.id
  }

  depends_on = [
    aws_efs_file_system.this
  ]
}

resource "aws_instance" "this" {
  count = var.ec2_on

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = data.template_file.mount_efs.rendered

  depends_on = [
    aws_efs_file_system.this
  ]
}
