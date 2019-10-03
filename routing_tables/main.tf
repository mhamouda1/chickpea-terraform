resource "aws_route_table" "public_subnets" {
  vpc_id = "${var.vpc}"

  route {
    cidr_block = "0.0.0.0/0"
    # gateway_id = "${aws_internet_gateway.main.id}"
    gateway_id = "${var.internet_gateway}"
  }

  tags = {
    Name = "Public subnets"
  }
}

resource "aws_route_table_association" "public_subnets_1" {
  count          = 2
  subnet_id      = "${var.public_subnets_1[count.index].id}"
  route_table_id = "${aws_route_table.public_subnets.id}"
}

resource "aws_route_table_association" "public_subnets_2" {
  count          = 2
  subnet_id      = "${var.public_subnets_2[count.index].id}"
  route_table_id = "${aws_route_table.public_subnets.id}"
}
