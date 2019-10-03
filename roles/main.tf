resource "aws_iam_role" "main_role" {
  name = "main_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "main_profile" {
  name = "main_profile"
  role = "${aws_iam_role.main_role.id}"
}

resource "aws_iam_role_policy" "allow_all_policy" {
  name = "allow_all_policy"
  role = "${aws_iam_role.main_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
