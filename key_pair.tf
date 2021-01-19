resource "tls_private_key" "pk" {
  algorithm = "RSA"
}
resource "aws_key_pair" "kpair" {
  key_name   = var.key_name
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.pk.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}