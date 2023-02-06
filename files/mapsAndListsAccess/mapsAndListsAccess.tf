provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

resource "aws_instance" "myec2" {
  ami = "ami-082b5a644766e0e6f"
#  instance_type = var.list[0]
  instance_type = var.objectExample.ap-south-1
}

variable "listExample" {
#  type = list(string) # You do not have to define a variable type, as TF can infer it by itself
  default = ["m5.large", "m5.xlarge", "t2.medium"]
}

variable "objectExample" {
#  type = object({ # You do not have to define a variable type, as TF can infer it by itself
#    "us-east-1" = string
#    "us-west-2" = string
#    "ap-south-1" = string
#  })
  default = {
    us-east-1 = "t2.micro"
    us-west-2 = "t2.nano"
    ap-south-1 = "t2.small"
  }
}
