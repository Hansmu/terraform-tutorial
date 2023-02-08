provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

# Data sources allow Terraform to use information defined outside of Terraform, defined by another separate
# Terraform configuration, or modified by functions.
# https://developer.hashicorp.com/terraform/language/data-sources

# A data block requests that Terraform read from a given data source ("aws_ami") and export the result under the given
# local name ("app_ami"). The name is used to refer to this resource from elsewhere in the same Terraform module, but
# has no significance outside of the scope of a module.

# Data Source: aws_ami
# Use this data source to get the ID of a registered AMI for use in other resources.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "app_ami" {
  #  (Optional) If more than one result is returned, use the most recent AMI.
  most_recent = true
  # (Optional) List of AMI owners to limit search.
  owners = ["amazon"]


  #  (Optional) One or more name/value pairs to filter off of.
  # https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
  filter {
    # The name of the AMI (provided during image creation).
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "instance-1" {
  # Reference the calculated data
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}