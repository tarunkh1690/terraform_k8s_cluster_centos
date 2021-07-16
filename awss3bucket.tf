resource "aws_s3_bucket" "bucket" {
  bucket = "k8s-join-master"
  force_destroy = true
  acl    = "private"

  tags = {
    Name        = "k8s-join-master"
  }
}
