variable "vpc_id" {
  type    = string
  default = null
}

variable "igw_name" {
  type    = string
  default = "tf-igw-default"
}

variable "route_name" {
  type    = string
  default = "tf-rt-azA"
}

variable "route_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "subnet_name" {
  type    = string
  default = "tf-sub-pub-azA"
}

variable "subnet_cidr" {
  type    = string
  default = "172.31.50.0/24"
}

variable "subnet_az" {
  type    = string
  default = "us-east-1a"
}

variable "sg_name" {
  type    = string
  default = "web-http"
}

variable "num_of_instances" {
  type    = number
  default = 1
}

variable "prefix_instance" {
  type    = string
  default = "ec2-tcc-webserver"
}

variable "prefix_eip" {
  type    = string
  default = "eip-tcc-webserver"
}

variable "prefix_interface" {
  type    = string
  default = "eni-tcc-webserver"
}

variable "key_name" {
  type    = string
  default = "tf-tcc-webserver"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ami" {
  type    = string
  default = "ami-0022f774911c1d690"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "tags" {
  type = map(any)
}