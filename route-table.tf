resource "aws_route_table" "k8s-public-crt" {
    vpc_id = "${aws_vpc.k8s-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.k8s-igw.id}" 
    }
    
    tags {
        Name = "k8s-public-crt"
    }
    depends_on = ["aws_subnet.k8s-subnet"]
}


resource "aws_route_table_association" "k8s-crta"{
    count = "${length(var.aws_vpc_subnet)}"
    subnet_id = "${element(aws_subnet.k8s-subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.k8s-public-crt.id}"
    depends_on = ["aws_subnet.k8s-subnet"]
}
