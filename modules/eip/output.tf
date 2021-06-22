#Expose his public IP to other modules
output "out_eip_ip" {
  value = aws_eip.my_eip.public_ip
}

#Expose eip-id to tne other module (use to make association with ec2)
output "out_eip_id" {
  value = aws_eip.my_eip.id
}