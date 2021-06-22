#Expose the Ebs_id to other modules (use to attach this vol to our ec2)
output "out_vol_id" {
  value = aws_ebs_volume.my_vol.id
}