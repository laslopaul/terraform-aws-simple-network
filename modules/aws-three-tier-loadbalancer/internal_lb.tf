resource "aws_lb" "internal_lb" {
  name            = "three-tier-internal-loadbalancer"
  internal        = true
  security_groups = [var.internal_lb_sg]
  subnets         = var.internal_lb_subnets
  idle_timeout    = 400
}

resource "aws_lb_target_group" "internal_lb_tg" {
  name     = "internal-lb-tg"
  protocol = var.internal_lb_tg_protocol
  port     = var.internal_lb_tg_port
  vpc_id   = var.vpc_id

  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 86400
  }

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "internal_lb_listener" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = var.internal_lb_listener_port
  protocol          = var.internal_lb_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_lb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "app_nodes" {
  autoscaling_group_name = var.app_nodes_asg
  lb_target_group_arn    = aws_lb_target_group.internal_lb_tg.arn
}