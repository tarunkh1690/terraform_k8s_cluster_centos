resource "aws_iam_policy" "k8s-policy" {
  name        = "k8s-policy"
  description = "policy for k8s cluster"
  policy      = "${file("policys3bucket.json")}"
}
