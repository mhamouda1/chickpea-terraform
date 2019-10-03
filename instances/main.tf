resource "aws_instance" "master" {
  ami           = "${var.amazon_ami}"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public_1[0].id}"

  key_name      = "${aws_key_pair.my_key_pair.id}"
  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh_and_web.id}",
    "${aws_vpc.main.default_security_group_id}",
    "${aws_security_group.development_testing.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"

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
    Name = "Master"
  }
}