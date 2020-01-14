resource "aws_iam_instance_profile" "k8s-profile" {
  name  = "k8s-profile"
  roles = ["${aws_iam_role.ec2-k8s_s3_access_role.name}"]
}
