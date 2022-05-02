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

Terraform supports a lot of providers. Providers define the cloud provider that
you are using. AWS, Azure, Google Cloud etc. After adding a provider, it is
important to run `terraform init` which will download plugins associated with the
provider.

Resources are the references to individual services that the provider offers.

Starting from v 0.13 it is suggested that a required_providers block should be 
included to specify the source and version of the provider. However, if it is
an officially supported provider by HashiCorp, then it will work without the
block as well, but it's not recommended.
````
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
````

Authentication configuration works differently based on the provider.

`terraform destroy` allows us to destroy all the resources that are created
within the folder.

`terraform destroy -target` will allow us to destroy specific resources. Target
is marked by resource type + local resource name.
`terraform destroy -target aws_instance.myec2`

If you remove a block defining the resource, then Terraform init will also pick 
up on the need to destroy and the plan will reflect that.

Terraform stores the state of the infrastructure that is being created from
the TF files. This state allows Terraform to map real world resources to your
existing configuration. Comparing with these state files allows TF to understand
whether something needs creating or destroying. `terraform.tfstate`

Terraform's primary function is to create, modify, and destroy infrastructure
resources to match the desired state described in a Terraform configuration.
Current state is the actual state of a resource that is currently deployed.
Terraform tries to ensure that the deployed infrastructure is based on the
desired state. If there is a difference between the two, Terraform plan presents
a description of the changes necessary to achieve the desired state. `terraform
refresh` will check the current state and refresh the TF state file depending on
that. If you just run `terraform plan`, then refresh happens behind the scenes
anyway.

If you manually change something in the provider environment related to the
resources that are managed by Terraform and the property isn't described in
the `.tf` file, then TF will simply ignore that property. It might not match
the state file, but the desired state is based on the `.tf` file. So if there
are no conflicts with the desired state, then no changes will be applied.

Provider plugins are released separately from Terraform itself. You should 
explicitly set a provider version. During `terraform init`, if the version
argument is not specified, the most recent provider will be downloaded 
during initialization. For production use, you should constrain the acceptable
provider versions via configuration to ensure that new versions with breaking 
changes will not be automatically installed. The version number arguments
can specify the version in different ways.
* \>=1.0 greater than equal to the version
* <=1.0 less than equal to the version
* ~>2.0 any version in the 2.x range
* \>=2.10,<=2.30 any version between 2.10 and 2.30
````
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
````

`.terraform.lock.hcl` allows us to lock to a specific version of the provider. If
a particular provider already has a selection recorded in the lock file, Terraform
will always re-select that version for installation, even if a newer version has
become available. You can override that behavior by adding the `-upgrade` option
when you run `terraform init`.

Terraform has the capability to output the attribute of a resource with the 
output values. An outputted attribute can not only be used for the user for
reference, but it can also act as an input to other resource being created
via Terraform.

We can have a central source from which we can import values from.

Variables can be assigned values in multiple ways. For example:
* Environment variables
  * Define a global variable using a prefix `TF_VAR_myVariableName="t2.nano"`
* Command line flags `terraform plan -var="myVariableName=t2.small"`
* From a file
  * Create a `.tfvars` file. If it's set to `terraform.tfvars`, then it gets read
  by default. If something else, then you have to explicitly define the name to read.
  `terraform plan -var-file="customVarsFile.tfvars"`
  * Add key, value pairs in there `myVariableName="t2.large"`
* Variable defaults ````variable "myVariableName" { default = "t2.micro" }````

If no value is provided, then when triggering TF it will ask for the value of
variable via command prompt.

Generally a variables file is defined for default values. E.g. `variables.tf` 
that contains the default assignments `default = ...`. Also, a `.tfvars` file is
defined for default overrides.
