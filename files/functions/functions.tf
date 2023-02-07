provider "aws" {
  region     = var.region
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

locals {
  # Built in functions of Terraform
  # formatdate(spec, timestamp)
  # timestamp returns a UTC timestamp string in RFC 3339 format.
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  default = ["firstec2","secondec2"]
}

variable "ami" {
  default = {
    "us-east-1" = "ami-0323c3dd2da7fb37d"
    "us-west-2" = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0470e33cd681b2476"
  }
}

resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  # Built in functions of Terraform
  # file reads the contents of a file at the given path and returns them as a string.
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "app-dev" {
  # Built in functions of Terraform
  # Essentially just selects a map value for the string. Both of these are defined above.
  # lookup(map, key, default). default is not optional since version 0.7. If the default was optional, then it would not
  # differ from the native syntax of var.ami[var.region].
  ami = lookup(var.ami,var.region, var.ami.us-east-1)
  instance_type = "t2.micro"
  key_name = aws_key_pair.loginkey.key_name
  count = 2

  tags = {
    # Built in functions of Terraform
    # element(list, index)
    # Use the built-in index syntax list[index] in most cases. Use this function only for the special additional "wrap-around" behavior
    Name = element(var.tags,count.index)
  }
}


output "timestamp" {
  value = local.time
}