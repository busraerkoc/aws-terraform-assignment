output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "web_instance_public_ip" {
  value = aws_instance.web.*.public_ip
}

output "application_instance_private_ip" {
  value = aws_instance.application.*.private_ip
}

output "information_to_connect_bastion" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.bastion.public_ip}"
}