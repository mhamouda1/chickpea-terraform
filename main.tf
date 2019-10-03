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

module "public_subnets" {
  source = "./public_subnets"
  project_name = "${var.project_name}"
  vpc = "${module.vpc.id}"
  public_subnets_1 = "${var.public_subnets_1}"
  public_subnets_2 = "${var.public_subnets_2}"
}

module "roles" {
  source = "./roles"
}

module "security_groups" {
  source = "./security_groups"
  vpc = "${module.vpc.id}"
}

module "routing_tables" {
  source = "./routing_tables"
  vpc = "${module.vpc.id}"
  public_subnets_1 =  "${module.public_subnets.public_subnets_1}"
  public_subnets_2 =  "${module.public_subnets.public_subnets_2}"
  internet_gateway =  "${module.vpc.internet_gateway}"
}

module "elasticache" {
  source = "./elasticache"
  subnet_ids = ["${module.public_subnets.public_subnets_1[0].id}", "${module.public_subnets.public_subnets_1[1].id}"]
  num_cache_nodes = "${var.num_cache_nodes}"
}

module "ecr" {
  source = "./ecr"
  project_name = "${var.project_name}"
}

module "amis" {
  source = "./amis"
}

module "key_pairs" {
  source = "./key_pairs"
}

module "elb" {
  source = "./elb"
  project_name = "${var.project_name}"
  security_groups = ["${module.security_groups.allow_all}"]
  subnets = ["${module.public_subnets.public_subnets_1[0].id}", "${module.public_subnets.public_subnets_2[0].id}"]
  target_group_arn =  "${module.target_groups.target_group_1}"
}

module "target_groups" {
  source = "./target_groups"
  vpc = "${module.vpc.id}"
  port = "${var.target_group_port}"
}

module "instances" {
  source = "./instances"
  project_name = "${var.project_name}"
  ami = "${module.amis.amazon_ami}"
  subnet_id = "${module.public_subnets.public_subnets_1[0].id}"
  key_name = "${module.key_pairs.my_key_pair}"
  security_groups = ["${module.security_groups.allow_all}"]
  iam_instance_profile = "${module.roles.main_instance_profile}"
}

# module "rds" {
  # subnet_ids = ["${module.public_subnets.public_subnets_1[0].id}", "${module.public_subnets.public_subnets_2[0].id}"]
  # vpc_security_group_ids = ["${module.security_groups.allow_all}"]
  # database = "${var.database}"
# }
