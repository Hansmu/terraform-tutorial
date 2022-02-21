provider "aws" { # Tell TF what provider you are using and configure it. In our example it's Amazon Web Services.
  region = "eu-west-1" # Where it will be deployed
  access_key = "my-access-key" # The simplest authentication method for AWS.
  secret_key = "my-secret-key" # The simplest authentication method for AWS.
}

# We specify the resource that we want to create. In this case aws_instance means EC2 instance. The second parameter is the
# name of the resource.
resource "aws_instance" "my-first-ec2-instance" {
  # Configuring here is just like stepping through the steps in AWS. Specify the AMI, specify the instance type etc.
  # If you ignore properties, then the default will be chosen.
  ami = "" # AMI IDs are specific to regions, so if you change the region, you'll probably have to update the AMI ID as well.
  instance_type = "t2.micro"
}