provider "aws" {
  region     = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY_ID}"
  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
}

module "s3" {
  source = "./s3"
  project_name = "${var.project_name}"
}

module "vpc" {
  source = "./vpc"
  project_name = "${var.project_name}"
}
