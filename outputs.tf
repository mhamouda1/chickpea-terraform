output "database" {
  value = "${module.rds.address}"
}

output "s3" {
  value = "${module.s3.bucket}"
}

output "elasticache" {
  value = "${module.elasticache.cluster_address}"
}

output "ecr" {
  value = "${module.ecr.repository_url}"
}
