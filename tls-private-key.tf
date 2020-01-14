resource "tls_private_key" "sshkeys" {
  algorithm   = "RSA"
  rsa_bits = "2048"
}
