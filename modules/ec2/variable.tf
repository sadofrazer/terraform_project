#Used for tag all our aws resources or objects
variable "author" {
  type    = string
  default = "frazer"
}

#Used to customizise the instance type of our ec2
variable "instance_type" {
  type    = string
  default = "t2.nano"
}

#Used to specify which key pair will be use by our ec2 to enable the ssh connection
variable "ssh_key" {
  type    = string
  default = "frazer-kp"
}

#use to specify the availability zone we'll use
variable "az" {
  type    = string
  default = "us-east-1b"
}

#Used to retrieve the sg_name of our sg module's output which contains the name of the security group; this variabe permit use to make the link between our ec2 an his sg.  
variable "sg_name" {
  type    = string
  default = "NULL"
}

#Used to retrieve the public_ip of our eip module's output which contains the PUBLIC IP we'll use to create the ec2_file_infos in ec2 module
variable "public_ip" {
  type    = string
  default = "NULL"
}

#User name we'll use to etablish the remote connexion with our ec2 instance; we also use this variable as ansible_user for run the ansible_odoo role
variable "user" {
  type    = string
  default = "NULL"
}

#Used to do the privileges escalation when running our ansible_odoo roles
variable "sudo_pass" {
  type    = string
  default = "NULL"
}

#Used to specify the owner of or amazon image 
variable "ubuntu_account_number" {
  default = "099720109477"
}
