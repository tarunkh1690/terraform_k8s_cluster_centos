resource "aws_iam_policy_attachment" "policy-attach-k8s" {
  name       = "policy-attach-k8s"
  roles      = ["${aws_iam_role.ec2-k8s_s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.k8s-policy.arn}"
}
