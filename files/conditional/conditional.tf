provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}


#In terraform.tfvars you'd assign the override value for the variable based on the env you are in.
#isTest = false
variable "isTest" {
  default = true
}

resource "aws_instance" "dev" {
  ami = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
  count = var.isTest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami = "ami-082b5a644766e0e6f"
  instance_type = "t2.large"
  count = var.isTest == false ? 1 : 0
}