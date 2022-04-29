provider "aws" {
  region     = "us-west-2"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}

resource "aws_instance" "ec2_instance_to_use" {
  ami = "" # AMI IDs are specific to regions, so if you change the region, you'll probably have to update the AMI ID as well.
  instance_type = "t2.micro"
}

resource "aws_eip" "new_elastic_ip" {
  vpc = true
}

resource "aws_eip_association" "associated_eip_with_ec2" {
  instance_id = aws_instance.ec2_instance_to_use.id
  allocation_id = aws_eip.new_elastic_ip.id
}

resource "aws_security_group" "my_security_group" {
  name = "hans-first-security-group"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    # CIDR blocks has to be either an IP range or a security group ID
    cidr_blocks = ["${aws_eip.new_elastic_ip.public_ip}/32"]
  }
}