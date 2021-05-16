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
echo ECS_CLUSTER=${var.environment}-${var.ecs_cluster_name} >> /etc/ecs/ecs.config
echo 'ECS_DISABLE_PRIVILEGED=true' >> /etc/ecs/ecs.config
echo 'ECS_ENABLE_TASK_IAM_ROLE=true' >> /etc/ecs/ecs.config
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.environment}-${var.ecs_cluster_name}-asg"
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.ecs.name

  min_size                  = 0
  max_size                  = var.max_size
  health_check_grace_period = 600
  health_check_type         = "EC2"
  protect_from_scale_in     = true

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "this" {
  name = "${var.environment}-${var.ecs_cluster_name}-ecs_capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = var.max_step_size
      minimum_scaling_step_size = var.min_step_size
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}
