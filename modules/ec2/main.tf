data "aws_ami" "my_ubuntu_ami" {
  most_recent = true
  owners = ["${var.ubuntu_account_number}"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "frazer-ec2" {
  ami             = data.aws_ami.my_ubuntu_ami.id
  instance_type   = var.instance_type
  key_name        = var.ssh_key
  availability_zone = "${var.az}"
  security_groups = ["${var.sg_name}"]
  tags = {
    Name = "${var.author}-ec2"
  }

  root_block_device {
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command = " echo PUBLIC IP: ${var.public_ip} ; ID: ${aws_instance.frazer-ec2.id} ; AZ: ${aws_instance.frazer-ec2.availability_zone}; >> infos_ec2.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo apt install -y git",
      "sudo apt install -y ansible",
      "git clone https://github.com/sadofrazer/ansible_odoo.git",
      "cd ansible_odoo/",
      "git checkout -b aws_terraform",
      "git pull origin aws_terraform",
      "git fetch origin aws_terraform",
      "ansible-galaxy install -r requirements.yml",
      "ansible-playbook -i local_host.yml odoo.yml -e ansible_user=${var.user} -e ansible_sudo_pass=${var.sudo_pass}"
    ] 
    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = file("C:/Files/Docs Perso/DevOps/AWS/.aws/${var.ssh_key}.pem")
      host        = "${self.public_ip}"
    }
  }

}

