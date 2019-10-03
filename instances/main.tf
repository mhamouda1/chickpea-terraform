resource "aws_instance" "master" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet_id}"
  key_name      = "${var.key_name}"
  vpc_security_group_ids = "${var.security_groups}"

  iam_instance_profile = "${var.iam_instance_profile}"

  # provisioner "file" {
    # source      = "/root/.ssh/id_rsa"
    # destination = "~/default_my_key_pair.pem"
  # }

  # provisioner "file" {
    # source      = "/root/.ssh/id_rsa.pub"
    # destination = "/home/ec2-user/.ssh/id_rsa.pub"
  # }

  # provisioner "file" {
    # source      = "/root/.ssh/id_rsa"
    # destination = "/home/ec2-user/.ssh/id_rsa"
  # }

  # provisioner "file" {
    # source      = "scripts/master.sh"
    # destination = "/tmp/master.sh"
  # }

  # provisioner "remote-exec" {
    # inline = [
      # "sudo chmod +x /tmp/master.sh",
      # "sudo bash /tmp/master.sh S3_BUCKET=${module.s3.bucket_name}",
    # ]
  # }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = "${self.public_ip}"
    private_key = file("/root/.ssh/id_rsa")
  }

  tags = {
    Name = "${var.project_name}-master"
  }
}
