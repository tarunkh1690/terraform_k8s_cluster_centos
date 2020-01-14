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
        cidr_blocks = ["106.193.0.0/16"]
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["172.31.0.0/16"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["106.193.0.0/16"]
    }
    tags {
        Name = "k8s-security-group"
    }
}
