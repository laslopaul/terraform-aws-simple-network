resource "aws_launch_template" "app_nodes" {
  name_prefix   = "app_node"
  instance_type = var.app_tier_instance_type
  image_id      = data.aws_ami.ubuntu.id
  key_name      = aws_key_pair.bastion_ssh_key.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_app_tier]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app_node"
      tier = "app"
    }
  }
}

resource "aws_autoscaling_group" "app_nodes" {
  name                = "asg_app_nodes"
  vpc_zone_identifier = var.subnets_app_tier
  min_size            = var.app_tier_min_nodes
  max_size            = var.app_tier_max_nodes
  desired_capacity    = var.app_tier_desired_capacity

  launch_template {
    id      = aws_launch_template.app_nodes.id
    version = "$Latest"
  }
}