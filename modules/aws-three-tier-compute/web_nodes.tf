resource "aws_launch_template" "web_nodes" {
  name_prefix            = "web_node"
  instance_type          = var.web_tier_instance_type
  image_id               = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.bastion_ssh_key.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_web_tier]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web_node_${uuid()}"
      tier = "web"
    }
  }
}

/*
data "aws_lb_target_group" "three_tier_tg" {
  name = var.lb_tg_name
}
*/

resource "aws_autoscaling_group" "web_nodes" {
  name                = "asg_web_nodes"
  vpc_zone_identifier = var.subnets_web_tier
  min_size            = var.web_tier_min_nodes
  max_size            = var.web_tier_max_nodes
  desired_capacity    = var.web_tier_desired_capacity

  #target_group_arns = [data.aws_lb_target_group.three_tier_tg.arn]

  launch_template {
    id      = aws_launch_template.web_nodes.id
    version = "$Latest"
  }
}

/*
resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.three_tier_app.id
  lb_target_group_arn    = var.lb_tg
}
*/