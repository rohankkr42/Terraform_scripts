# Run the "aws configure" and provide the Access_key and secret_access_key

# Configure the aws
provider "aws" {
	region = "us-east-2" # Choose the desire aws region
}

# Create AWS instance 
resource "aws_instance" "example" {
  ami           = "ami-785db401" # ami differs from region to region
  instance_type = "t2.micro" # eg (t2.large,t3.large)
  
  tags {
    Name = "terraform-example"   # Tags used to differenciate instances
  }
}
