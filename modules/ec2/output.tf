output "out_instance_id" {
  value = aws_instance.frazer-ec2.id
}

output "out_instance_az" {
  value = aws_instance.frazer-ec2.availability_zone
}
