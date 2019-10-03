resource "random_integer" "main" {
  min = 1
  max = 999
}

resource "aws_lb_target_group" "target_group_1" {
  name                 = "target-group-${random_integer.main.result}"
  port     = "${var.port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc}"
  deregistration_delay = 0

  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 6
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_lb_target_group_attachment" "master" {
  # target_group_arn = "${aws_lb_target_group.target_group_1.arn}"
  # target_id        = "${aws_instance.master.id}"
  # port     = "${var.port}"
# }

# resource "aws_lb_target_group_attachment" "workers" {
  # count            = "${var.num_workers}"
  # target_group_arn = "${aws_lb_target_group.target_group_1.arn}"
  # target_id        = "${aws_instance.worker[count.index].id}"
  # port     = "${var.port}"
# }
