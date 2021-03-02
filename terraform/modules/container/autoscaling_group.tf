data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "ecs" {
  image_id             = data.aws_ami.ecs.image_id
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.ecs.id]
  instance_type        = var.instance_type
  user_data            = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
echo 'ECS_DISABLE_PRIVILEGED=true' >> /etc/ecs/ecs.config
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs" {
  name                      = "${var.ecs_cluster_name}-asg"
  vpc_zone_identifier       = var.subnet_ids
  launch_configuration      = aws_launch_configuration.ecs.name

  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_grace_period = 600
  health_check_type         = "EC2"

  lifecycle {
    create_before_destroy = true
  }
}
