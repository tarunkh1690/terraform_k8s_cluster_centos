resource "aws_subnet" "k8s-subnet" {
    count  = "${length(var.aws_vpc_subnet)}"
    vpc_id = "${aws_vpc.k8s-vpc.id}"
    cidr_block = "${element(values(var.aws_vpc_subnet), count.index)}"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "${element(keys(var.aws_vpc_subnet), count.index)}"
    depends_on              = [aws_vpc.k8s-vpc]

    tags = {
        Name = "k8s-subnet-${element(keys(var.aws_vpc_subnet), count.index)}"
    }
}
