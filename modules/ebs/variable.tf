#Used for tag all our aws resources or objects
variable "author" {
  type    = string
  default = "frazer"
}

#Use to customize the size of ow new EBS
variable "dd_size" {
  type    = number
  default = 2
}

#use to specify the availability zone we'll use
variable "az" {
  type    = string
  default = "us-east-1b"
}