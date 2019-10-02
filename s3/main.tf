resource "random_id" "s3" {
  byte_length = 11
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-${random_id.s3.hex}"
  acl    = "public-read"

  versioning {
    enabled = true
  }

  tags = {
    Name = "${var.project_name}"
  }
}
