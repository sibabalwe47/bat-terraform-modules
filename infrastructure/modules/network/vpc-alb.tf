resource "aws_lb" "alb" {
  name               = "${var.vpc_name}-alb-${random_id.backend_id.dec}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]

  lifecycle {
    create_before_destroy = true
  }


  tags = {
    Name = "${var.vpc_name}-alb-${random_id.backend_id.dec}"
  }

}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}


resource "aws_lb_target_group" "target_group" {
  name        = "${var.vpc_name}-tg-${random_id.backend_id.dec}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}
