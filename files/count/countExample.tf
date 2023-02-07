provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-KEY"
  secret_key = "YOUR-KEY"
}

# As count is set here, then a count object is accessible here. This comes into play where unique properties are needed.
resource "aws_iam_user" "lb" {
  count = 5 # Create 5 resources with this definition
  # Could utilize a list here as well or whatever else. "load-balancer-${elb_names[count.index]}"
  name = "load-balancer-${count.index}"
}
