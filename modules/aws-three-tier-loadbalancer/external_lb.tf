resource "aws_lb" "external_lb" {
  name            = "three-tier-external-loadbalancer"
  security_groups = [var.external_lb_sg]
  subnets         = var.external_lb_subnets
  idle_timeout    = 400
}

resource "aws_lb_target_group" "external_lb_tg" {
  name     = "external-lb-tg"
  protocol = var.external_lb_tg_protocol
  port     = var.external_lb_tg_port
  vpc_id   = var.vpc_id

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "external_lb_listener" {
  load_balancer_arn = aws_lb.external_lb.arn
  port              = var.external_lb_listener_port
  protocol          = var.external_lb_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_lb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "web_nodes" {
  autoscaling_group_name = var.web_nodes_asg
  lb_target_group_arn    = aws_lb_target_group.external_lb_tg.arn
}