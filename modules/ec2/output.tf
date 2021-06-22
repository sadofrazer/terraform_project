#Variable to expose the id of our instance to other module
output "out_instance_id" {
  value = aws_instance.frazer-ec2.id
}

#Variable to expose the az of our instance to other module
output "out_instance_az" {
  value = aws_instance.frazer-ec2.availability_zone
}
