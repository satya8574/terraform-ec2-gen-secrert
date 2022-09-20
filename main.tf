resource "aws_instance" "ec2-server" {
  ami           = var.ec2_ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.public-subnet.id

  #  subnet_id              = data.aws_subnet.public-subnet.id 
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = var.key_pair_name #"key_pair_tf"                                   
  tags = {
    Name        = var.ec2-server-name
    Environment = var.ec2-server-environment
    owner       = var.ec2-service-owner
    # Creator = data.aws_caller_identity.current.arn
    # Timestamp = local.current_time
  }
}

resource "aws_key_pair" "key_pair_tf" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "key_12" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_pair_filename
}

###################  security groups ################

resource "aws_security_group" "allow_tls" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = data.aws_vpc.vpcfetch.id
  ingress {
    description      = var.ingress_tls_from_vpc_description
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

