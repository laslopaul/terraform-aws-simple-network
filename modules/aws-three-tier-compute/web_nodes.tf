resource "aws_launch_template" "web_nodes" {
  name_prefix   = "web_node"
  instance_type = var.web_tier_instance_type
  image_id      = data.aws_ami.ubuntu.id
  key_name      = aws_key_pair.bastion_ssh_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.sg_web_tier]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web_node"
      tier = "web"
    }
  }
}

resource "aws_autoscaling_group" "web_nodes" {
  name                = "asg_web_nodes"
  vpc_zone_identifier = var.subnets_web_tier
  min_size            = var.web_tier_min_nodes
  max_size            = var.web_tier_max_nodes
  desired_capacity    = var.web_tier_desired_capacity

  launch_template {
    id      = aws_launch_template.web_nodes.id
    version = "$Latest"
  }
}