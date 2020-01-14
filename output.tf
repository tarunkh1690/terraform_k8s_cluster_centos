output "vpc_id" {
  value = ["${aws_vpc.k8s-vpc.*.id}"]
}

output "subnet" {
   value = ["${aws_subnet.k8s-subnet.*.id}"]
}

output "security_group" {
   value = ["${aws_security_group.k8s-security-group.*.id}"]
}

output "IAM-role" {
   value = ["${aws_iam_role.ec2-k8s_s3_access_role.name}"]
}

output "private_key" {
   value = ["${tls_private_key.sshkeys.private_key_pem}"]
}

output "key-pair" {
   value = ["${aws_key_pair.k8s-cluster-key.key_name}"]
}
