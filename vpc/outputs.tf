output "id" {
  value = "${aws_vpc.main.id}"
}

output "internet_gateway" {
  value = "${aws_internet_gateway.main.id}"
}
