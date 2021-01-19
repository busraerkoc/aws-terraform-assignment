resource "aws_instance" "web" {
  count                  = var.count_web
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.web_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.kpair.key_name
  vpc_security_group_ids = ["${aws_security_group.sg_web.id}"]

  root_block_device {
    encrypted  = true
    kms_key_id = aws_kms_key.kms_key.id
  }

  lifecycle {
    ignore_changes = [root_block_device[0].kms_key_id]
  }

  tags = {
    "Name" = "web-${count.index + 1}"
  }
  volume_tags = {
    "backup" = "True"
  }
  user_data = data.template_file.userdata_web.rendered
}

resource "aws_instance" "application" {
  count                  = var.count_app
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = aws_subnet.application_sb.id
  instance_type          = var.application_instance_type
  key_name               = aws_key_pair.kpair.key_name
  vpc_security_group_ids = ["${aws_security_group.sg_application.id}"]
  root_block_device {
    encrypted  = true
    kms_key_id = aws_kms_key.kms_key.id
  }
  lifecycle {
    ignore_changes = [root_block_device[0].kms_key_id]
  }
  tags = {
    "Name" = "application-${count.index + 1}"
  }
  volume_tags = {
    "backup" = "True"
  }
  user_data = data.template_file.userdata_application.rendered
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.bastion_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.kpair.key_name
  vpc_security_group_ids      = ["${aws_security_group.sg_bastion.id}"]
  lifecycle {
    ignore_changes = [root_block_device[0].kms_key_id]
  }
  root_block_device {
    encrypted  = true
    kms_key_id = aws_kms_key.kms_key.id
  }
  tags = {
    "Name" = "bastion"
  }
  volume_tags = {
    "backup" = "True"
  }
}

resource "aws_instance" "storage_gateway_server" {
  ami                         = data.aws_ami.storage_gw.id
  instance_type               = "m4.xlarge"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.kpair.key_name
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.sg_sgw.id}"]
  root_block_device {
    volume_size = 80
    encrypted   = true
    volume_type = "gp2"
  }
  tags = {
    "Name" = "sgw-server"
  }
}

resource "aws_kms_key" "kms_key" {
  description = "KMS key for my instance's disk"
}
