variable "author" {
  type    = string
  default = "frazer"
}

variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "ssh_key" {
  type    = string
  default = "devops-frazer"
}

variable "sg_name" {
  type    = string
  default = "NULL"
}

variable "public_ip" {
  type    = string
  default = "NULL"
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

variable "az" {
  type    = string
  default = "us-east-1b"
}

variable "user" {
  type    = string
  default = "NULL"
}