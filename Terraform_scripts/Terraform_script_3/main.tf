# Configure the AWS provider
provider "aws" {
  region = "eu-west-2"
}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "Allow_web_server_port" {
  name = "Allow_web_server_port"
  
  ingress {
    from_port	  = 8080  			# Web_server_port_number
    to_port	    = 8080
    protocol	  = "tcp" 			# protocol
    cidr_blocks	= ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "My_instance" {
  ami                     = "ami-785db401"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = ["${aws_security_group.Allow_web_server_port.id}"]
  
  user_data = <<-EOF                            # User data to be implemented once the vm is up
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p 8080 &  # nohup allows a process to continue running after the user exits the shel, -f runs the HTTP server in teh foreground, & puts the command in background
	      EOF                               # EOF -END of file
			  
  tags {
    Name = "terraform-example"
  }
}

# Output variable: Public IP address
output "public_ip" {
  value = "${aws_instance.My_instance.public_ip}"
}
