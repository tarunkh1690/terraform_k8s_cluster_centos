resource "aws_iam_role" "ec2-k8s_s3_access_role" {
  name               = "k8s-s3-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}
