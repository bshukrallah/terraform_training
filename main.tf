provider "aws" {
    profile = default
    region = "us-east-1"
}


resource "aws_instance" "my_first_server" {
    ami = "ami-0be2609ba883822ec"
    instance_type = "t2.micro"  
}