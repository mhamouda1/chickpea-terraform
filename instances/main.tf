resource "aws_instance" "master" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet_id}"
  key_name      = "${var.key_name}"
  vpc_security_group_ids = "${var.security_groups}"
  iam_instance_profile = "${var.iam_instance_profile}"

  provisioner "file" {
    source      = "scripts/remote"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = "/root/.ssh/id_rsa.pub"
    destination = "/home/ec2-user/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/scripts/remote/master.sh",
      "sudo bash /tmp/scripts/remote/master.sh S3_BUCKET=${var.s3_bucket}",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = "${self.public_ip}"
    private_key = file("/root/.ssh/id_rsa")
  }

  tags = {
    Name = "${terraform.workspace}-${var.project_name}-master"
  }
}

resource "aws_instance" "worker" {
  count         = "${var.num_workers}"
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet_id}"
  key_name      = "${var.key_name}"
  vpc_security_group_ids = "${var.security_groups}"
  iam_instance_profile = "${var.iam_instance_profile}"

  provisioner "file" {
    source      = "scripts/remote"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = "/root/.ssh/id_rsa.pub"
    destination = "/home/ec2-user/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/scripts/remote/worker.sh",
      "sudo bash /tmp/scripts//remote/worker.sh S3_BUCKET=${var.s3_bucket} NODE=${count.index}",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = "${self.public_ip}"
    private_key = file("/root/.ssh/id_rsa")
  }

  tags = {
    Name = "${terraform.workspace}-${var.project_name}-worker-${count.index}"
  }

  # depends_on = [aws_instance.master]
}
