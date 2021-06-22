resource "aws_ebs_volume" "my_vol" {
  availability_zone = "${var.az}"
  size              = var.dd_size

  tags = {
    Name = "${var.author}-ebs"
  }
}