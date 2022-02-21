provider "aws" {
  region     = "us-west-2"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}

resource "aws_instance" "ec2_instance_to_bind" {
  ami = "" # AMI IDs are specific to regions, so if you change the region, you'll probably have to update the AMI ID as well.
  instance_type = "t2.micro"
}

resource "aws_eip" "my_lb_name_here" {
  vpc      = true
}

// Here we just name the output property
output "eip" {
  /* When defining the output, then we are identifying the value using the <resource type>.<resource name>.<property>
  The property is optional. If you don't specify it, then it'll show all of the properties allowed into the output. */
  value = aws_eip.my_lb_name_here.public_ip
}

resource "aws_s3_bucket" "my_s3_bucket_here" {
  bucket = "kplabs-attribute-demo-001"
}

// Here we just name the output property
output "mys3bucket" {
  /* When defining the output, then we are identifying the value using the <resource type>.<resource name>.<property>
  The property is optional. If you don't specify it, then it'll show all of the properties allowed into the output. */
  value = aws_s3_bucket.my_s3_bucket_here.bucket_domain_name
}

// Create an association between the EC2 instance and the EIP
resource "aws_eip_association" "eip_association" {
  // Can reference the instance ID the same what you'd output the value into the output <resource type>.<resource name>.<property>
  // Can add the values into strings and such using ${} for example a CIDR block would be ["${aws_eip.my_lb_name_here.public_ip}/32"]
  instance_id = aws_instance.ec2_instance_to_bind.id
  allocation_id = aws_eip.my_lb_name_here.id
}