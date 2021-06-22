#Expose the security group name to other modules
output "out_sg_name" {
  value = aws_security_group.my_sg.name
}