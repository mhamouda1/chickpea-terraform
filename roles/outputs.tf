output "main_instance_profile" {
  value = "${aws_iam_instance_profile.main_profile.name}"
}
