resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds_subnet_group"
  description = "Subnet Group for RDS"
  subnet_ids  = "${var.subnet_ids}"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "mydb"

  name                     = var.database.name
  username                 = var.database.username
  password                 = var.database.password

  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.id}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
}
