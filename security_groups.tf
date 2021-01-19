resource "aws_security_group" "sg_bastion" {
  name   = "sg_bastion"
  vpc_id = aws_vpc.new_vpc.id
  ingress {
    cidr_blocks = ["${var.my_ip}/32"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

}
resource "aws_security_group_rule" "application_to_web" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_web.id
  source_security_group_id = aws_security_group.sg_application.id
}
resource "aws_security_group_rule" "web_to_application" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_application.id
  source_security_group_id = aws_security_group.sg_web.id
}

resource "aws_security_group_rule" "bastion_to_web" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_web.id
  source_security_group_id = aws_security_group.sg_bastion.id
}

resource "aws_security_group_rule" "bastion_to_application" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_application.id
  source_security_group_id = aws_security_group.sg_bastion.id
}

resource "aws_security_group" "sg_sgw" {
  name   = "sg_sgw"
  vpc_id = aws_vpc.new_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to NFS shares that your gateway exposes."
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to NFS shares that your gateway exposes."
    from_port   = 2049
    protocol    = "udp"
    to_port     = 2049
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to the port mapper that your gateway exposes."
    from_port   = 111
    protocol    = "tcp"
    to_port     = 111
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to the port mapper that your gateway exposes."
    from_port   = 111
    protocol    = "udp"
    to_port     = 111
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to mounts that your gateway exposes."
    from_port   = 20048
    protocol    = "tcp"
    to_port     = 20048
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "For local systems to connect to mounts that your gateway exposes."
    from_port   = 20048
    protocol    = "udp"
    to_port     = 20048
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_security_group" "sg_web" {
  name   = "sg_web"
  vpc_id = aws_vpc.new_vpc.id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_security_group" "sg_application" {
  name   = "sg_application"
  vpc_id = aws_vpc.new_vpc.id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}
resource "aws_security_group" "sg_efs" {
  name        = "sg_efs"
  description = "Sg for efs"
  vpc_id      = aws_vpc.new_vpc.id
  ingress {
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}