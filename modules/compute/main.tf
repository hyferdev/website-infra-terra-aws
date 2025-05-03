resource "aws_instance" "public_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = true

  tags = {
    Name = "hyfer-public-vm"
  }
}

resource "aws_instance" "webfront_vm_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id_1
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = false

  tags = {
    Name = "hyfer-web-1"
  }
}

resource "aws_instance" "webfront_vm_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id_2
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = false

  tags = {
    Name = "hyfer-web-2"
  }
}

# Find the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

