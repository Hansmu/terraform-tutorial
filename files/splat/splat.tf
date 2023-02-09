provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}
resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

output "arns" {
  # The special [*] symbol iterates over all the elements of the list given to
  # its left and accesses from each one the attribute name given on its right.
  value = aws_iam_user.lb[*].arn
}