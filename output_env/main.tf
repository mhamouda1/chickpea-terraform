resource "null_resource" "output_env" {
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ruby scripts/local/set_outputs.rb DATABASE_HOST=${var.database} MEMCACHED_SERVER=${var.elasticache} S3_BUCKET=${var.s3}"
  }
}
