resource "aws_instance" "master-server" {
  count = "${var.master_instance_count}"
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "${var.server_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.k8s-profile.name}"
  count  = "${length(aws_subnet.k8s-subnet.*.id)}"
  subnet_id = "${element(aws_subnet.k8s-subnet.*.id, count.index)}"
  vpc_security_group_ids =  ["${aws_security_group.k8s-security-group.id}"]
  key_name = "${aws_key_pair.k8s-cluster-key.key_name}"
  tags = {
          Name = "master-server-${count.index + 1}"
         }
  depends_on = ["aws_key_pair.k8s-cluster-key"]
}

resource "aws_instance" "client-server" {
  count = "${var.node_instance_count}"
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "${var.client_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.k8s-profile.name}"
  count  = "${length(aws_subnet.k8s-subnet.*.id)}"
  subnet_id = "${element(aws_subnet.k8s-subnet.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.k8s-security-group.id}"]
  key_name = "${aws_key_pair.k8s-cluster-key.key_name}"
  tags = {
          Name = "client-server-${count.index + 1}"
         }

  depends_on = ["aws_key_pair.k8s-cluster-key"]
}
