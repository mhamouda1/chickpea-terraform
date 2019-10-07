resource "null_resource" "set_database_values" {
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOF
ruby scripts/local/set_elasticsearch.rb DATABASE_HOST=${var.database.address} DATABASE_NAME=${var.database.name} DATABASE_USERNAME=${var.database.username} DATABASE_PASSWORD=${var.database.password} DATABASE_ENVIRONMENT=${terraform.workspace} S3_NAME=${var.s3.tags.Name} S3_BUCKET=${var.s3.bucket} S3_ENVIRONMENT=${terraform.workspace} ECR_URL=${var.ecr.repository_url} ECR_ENVIRONMENT=${terraform.workspace}
EOF
  }
}
