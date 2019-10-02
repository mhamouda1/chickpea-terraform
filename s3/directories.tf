resource "aws_s3_bucket_object" "assets" {
  bucket = "${aws_s3_bucket.main.bucket}"
  key    = "assets/"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "kubernetes" {
  bucket = "${aws_s3_bucket.main.bucket}"
  key    = "config/kubernetes/"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "docker" {
  bucket = "${aws_s3_bucket.main.bucket}"
  key    = "config/docker/"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "terraform" {
  bucket = "${aws_s3_bucket.main.bucket}"
  key    = "config/terraform/"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "jenkins" {
  bucket = "${aws_s3_bucket.main.bucket}"
  key    = "config/jenkins/"
  acl    = "public-read"
}
