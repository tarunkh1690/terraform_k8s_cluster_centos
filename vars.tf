variable "aws_region" {
#  type    = "string"
  default = "ap-south-1"
}

variable "aws_vpc_cidr" {
#  type    = "string"
  default = "10.10.0.0/16"
}

variable "aws_vpc_subnet" {
   default = {
       ap-south-1a = "10.10.1.0/24"
       ap-south-1b = "10.10.2.0/24"
       ap-south-1c = "10.10.3.0/24"
	}
}

variable "server_instance_type" {
  default = "t2.micro"
}

variable "client_instance_type" {
  default = "t2.micro"
}

variable "master_instance_count" {
  default = "1"
}

variable "node_instance_count" {
  default = "2"
}


variable "AMIS" {
  default = {
    ap-south-1 = "ami-011c99152163a87ae"
    ap-south-1b = "ami-011c99152163a87ae"
    ap-south-1c = "ami-011c99152163a87ae"
  }
}

