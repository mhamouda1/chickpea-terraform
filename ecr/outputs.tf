output "repository_url" {
  value = "${aws_ecr_repository.main.repository_url}"
}

output "object" {
  value = "${aws_ecr_repository.main}"
}
