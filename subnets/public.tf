resource "aws_subnet" "public_1" {
  count                   = length(var.public_subnets_1)
  vpc_id                  = "${var.vpc}"
  cidr_block              = "${var.public_subnets_1[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public-us-east-1a-${var.public_subnets_1[count.index]}"
  }
}

resource "aws_subnet" "public_2" {
  count                   = length(var.public_subnets_2)
  vpc_id                  = "${var.vpc}"
  cidr_block              = "${var.public_subnets_2[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public-us-east-1b-${var.public_subnets_2[count.index]}"
  }
}
