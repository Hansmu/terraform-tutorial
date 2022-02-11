<h1>Terraform</h1>
When you want to launch a resource in AWS, there are three important considerations.

1. How will you authenticate to AWS?
2. Which region the resource needs to be launched in?
3. Which resource do you want to launch?

When running your TF file, then the first you need to do is run `terraform init`.
This will check to see the provider and download the provider related plugins.

Next you'd run `terraform plan` to get the information on what TF is planning
to create.

Finally `terraform apply` will actually run the script and create the resources 
and what not.