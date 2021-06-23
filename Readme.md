# Terraform + Nginx Server: Create AWS ressources and installing nginx server

[![CI](icones/nginx_icon-100.png)](https://github.com/sadofrazer/terraform_project.git)

The purposes of this project is to deploys an ec2 instances with a fixed public Ip, security groups and one additional EBS to store our personnal data. After deploying the AWS ec2 instance with its right others link objects, we run automatically on this ec2 instance the installation of nginx server

Find below a light description of this project source code.

## Terraform modules

### Requirements

This terraform project uses 04 modules to create one aws ec2 instance with the right objects association. The specifics needs for this project is the terraform aws provider libray and aws account credentials

### Attributes definition

Available variables are listed below, along with default values (see `modules/<module_name>/variable.tf`):

we have to use 04 modules (ec2, eip, sg and ebs) to create our ec2 instance, public IP, SG and additionnal EBS. In order to link these modules to each other, wue used output files that we well describe below as well

#### ec2 module 

##### Variables

Used for tag all aws resources in this project

    variable "author" {
      type    = string
      default = "frazer"
    }

Used to customizise the instance type of our ec2

    variable "instance_type" {
      type    = string
      default = "t2.nano"
    }

Used to specify which key pair will be use by our ec2 to enable the ssh connection

    variable "ssh_key" {
      type    = string
      default = "devops-frazer"
    }

use to specify the availability zone we'll use

    variable "az" {
      type    = string
      default = "us-east-1b"
    }

Used to retrieve the sg_name of our sg module's output which contains the name of the security group; this variabe permit use to make the link between our ec2 an his sg. 

    variable "sg_name" {
      type    = string
      default = "NULL"
    }

Used to retrieve the public_ip of our eip module's output which contains the PUBLIC IP we'll use to create the ec2_file_infos in ec2 module

    variable "public_ip" {
      type    = string
      default = "NULL"
    }

User name we'll use to etablish the remote connexion with our ec2 instance

    variable "user" {
      type    = string
      default = "NULL"
    }

Used to specify the owner of or amazon image 

    variable "ubuntu_account_number" {
      default = "099720109477"
    }
   
##### Output file
  
Output to expose the id of our instance to other module

    output "out_instance_id" {
      value = aws_instance.frazer-ec2.id
    }

Output to expose the az of our instance to other module

    output "out_instance_az" {
      value = aws_instance.frazer-ec2.availability_zone
    }


#### sg module variable

##### Variable

this module just have the <author> variable to tag all its resources

##### Output file
 
Expose the security group name to other modules
    
     output "out_sg_name" {
       value = aws_security_group.my_sg.name
     }

#### eip module variable

##### Variable

Any variable for this module

##### Output file
  
Expose his public IP to other modules
    
    output "out_eip_ip" {
      value = aws_eip.my_eip.public_ip
    }

Expose eip-id to tne other module (use to make association with ec2)
    
    output "out_eip_id" {
      value = aws_eip.my_eip.id
    }

#### ebs module variable

##### Variable
    
Used for tag all our aws resources or objects
  
    variable "author" {
      type    = string
      default = "frazer"
    }

Use to customize the size of ow new EBS
    
    variable "dd_size" {
      type    = number
      default = 2
    }

use to specify the availability zone we'll use
    
    variable "az" {
      type    = string
      default = "us-east-1b"
    } 

##### Output file

Expose the Ebs_id to other modules (use to attach this vol to our ec2)
    
    output "out_vol_id" {
      value = aws_ebs_volume.my_vol.id
    }

## Dependencies

!!! Make sure to have the correct variable value before run this app.

### Example of use
  
    provider "aws" {
      region                  = "us-east-1"
      shared_credentials_file = "C:/Files/Docs Perso/DevOps/AWS/.aws/credentials"
    }

    #Appel du module de création du sg
    module "sg" {
      source        = "../modules/sg"
      author = "app"
    }

    #Appel module de création du volume
    module "ebs" {
      source        = "../modules/ebs"
      dd_size = 5
      author = "app"
    }

    #Appel du module de création de l'adresse ip publique
    module "eip" {
      source        = "../modules/eip"
    }
    
    #Appel du module de création de ec2
    module "ec2" {
      source        = "../modules/ec2"
      author        = "app"
      instance_type = "t2.micro"
      sg_name= "${module.sg.out_sg_name}"
      public_ip = "${module.eip.out_eip_ip}"
      user = "user_name"
    }
    
    #//////////////////////////////////////////////////
    #Creation des associations nécessaires entre nos ressources

    resource "aws_eip_association" "eip_assoc" {
      instance_id = module.ec2.out_instance_id
      allocation_id = module.eip.out_eip_id
    }
    resource "aws_volume_attachment" "ebs_att" {
      device_name = "/dev/sdh"
      volume_id   = module.ebs.out_vol_id
      instance_id = module.ec2.out_instance_id
    }


### Author Information

This role was created in 2021 by [Frazer SADO](https://github.com/sadofrazer/), author of [Terraform + Ansible odoo](https://github.com/sadofrazer/ansible_odoo/tree/aws_terraform).
