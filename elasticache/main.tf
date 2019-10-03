resource "aws_elasticache_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = "${var.subnet_ids}"
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "my-cluster"
  engine               = "memcached"
  engine_version       = "1.5.16"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "default.memcached1.5"
  port                 = 11211

  subnet_group_name  = "${aws_elasticache_subnet_group.main.name}"
}
