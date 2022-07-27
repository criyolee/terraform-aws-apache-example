
provider "aws" {
  region = "us-east-1"
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-${var.env}"
  public_key = var.public_key
}


data "aws_vpc" "default" {
  id = var.vpc_id
}


resource "aws_security_group" "sg_allow_ssh" {
  name        = var.sg_name
  description = "sg_allow_ssh security group to allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress = [{
    description      = "HTTP"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # use main because its the default sg
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "SSH"
      from_port        = var.ssh_port
      to_port          = var.ssh_port
      protocol         = "tcp"
      cidr_blocks      = [var.my_ip]    # use main because its the default sg
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
  }]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}


data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
  #template = file("${path.module}/userdata.yaml")
}


resource "aws_instance" "MyProvisionerInstance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh.id]
  key_name               = aws_key_pair.deployer.key_name
  user_data              = data.template_file.user_data.rendered

  ## Remote-Exec
  connection {
    type        = var.connection_type
    user        = var.ec2_user
    private_key = file("${var.ssh_private_key}")
    host        = self.public_ip
  }

  tags = {
    Name = var.server_name
  }
}


resource "null_resource" "status" {
  triggers = {
    instance_ids = aws_instance.MyProvisionerInstance.id
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.MyProvisionerInstance.id}"
  }
  depends_on = [aws_instance.MyProvisionerInstance]
}

