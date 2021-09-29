resource "aws_efs_file_system" "this" {
  creation_token   = "remote-dev-efs"
  performance_mode = "generalPurpose"
  encrypted        = true
}

resource "aws_efs_mount_target" "this" {
  count = var.ec2_on

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = aws_instance.this[0].subnet_id
  security_groups = [aws_security_group.mnt.id]
}
