resource "aws_lb" "main" {
  name               = "${var.project_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups = "${var.security_groups}"
  subnets = "${var.subnets}"
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = "${aws_lb.main.arn}"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = "${var.target_group_arn}"
  }
}
