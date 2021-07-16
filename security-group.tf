resource "aws_security_group" "k8s-security-group" {
    vpc_id = "${aws_vpc.k8s-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["103.0.0.0/8","47.9.168.0/24"]
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["10.10.0.0/16"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["103.0.0.0/8","47.9.168.0/24"]
    }
    tags = {
        Name = "k8s-security-group"
    }
}
