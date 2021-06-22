provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:/Files/Docs Perso/DevOps/AWS/.aws/credentials"
}

# terraform {
#   backend "s3" {
#     bucket                  = "terraform-backend-frazer"
#     key                     = "frazer-dev.tfstate"
#     region                  = "us-east-1"
#     shared_credentials_file = "C:/Files/Docs Perso/DevOps/AWS/.aws/credentials"
#   }
# }

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

# Appel du module de création de l'adresse ip pulique
module "eip" {
  source        = "../modules/eip"
}

# Appel du module de création de ec2
module "ec2" {
  source        = "../modules/ec2"
  author        = "app"
  instance_type = "t2.micro"
  sg_name= "${module.sg.out_sg_name}"
  public_ip = "${module.eip.out_eip_ip}"
  user = "ubuntu"
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
