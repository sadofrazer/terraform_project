resource "aws_ebs_volume" "my_vol" {
  availability_zone = "us-east-1b"
  size              = var.dd_size

  tags = {
    Name = "${var.author}-ebs"
  }
}