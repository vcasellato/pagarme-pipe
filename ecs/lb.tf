

resource "aws_lb" "pagar_alb_test" {
  name               = "test-lb-pagarme"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg_pagarme.id]
  subnets            = [module.vpc.public_subnets[2], module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  enable_deletion_protection = true

  tags = {
    Environment = "pagarme"
  }
}

resource "aws_alb_target_group" "pagarme_teste_tg" {
  name                 = local.prefix
  port                 = local.container_port
  protocol             = "HTTP"
  vpc_id               = module.vpc.vpc_id
  target_type          = "ip"
  deregistration_delay = 5

  health_check {
    interval            = 8
    path                = "/"
    timeout             = 5
    unhealthy_threshold = 3
  }

  tags = local.tags
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.pagar_alb_test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.pagarme_teste_tg.arn
  }
}


resource "aws_lb_listener_rule" "pagarme_teste_rule" {
  listener_arn = aws_lb_listener.front_end.arn
  tags         = local.tags

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.pagarme_teste_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
