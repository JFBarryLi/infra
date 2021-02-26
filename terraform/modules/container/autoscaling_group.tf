resource "aws_launch_configuration" "ecs" {
    image_id             = "ami-088bea20d66c43d0e"
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.ecs.id]
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config"
    instance_type        = "t2.micro"
}

resource "aws_autoscaling_group" "ecs" {
    name                      = "${var.ecs_cluster_name}-asg"
    vpc_zone_identifier       = [var.subnet_id]
    launch_configuration      = aws_launch_configuration.ecs.name

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 1
    health_check_grace_period = 600
    health_check_type         = "EC2"
}
