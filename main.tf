resource "aws_instance" "my_first_server" {
    ami = "ami-0be2609ba883822ec"
    provider = "terraform_test"
    instance_type = "t2.micro"
    key_name = aws_key_pair.instance-key.key_name
        associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.allowSSH.id]
    tags = {
      "Name" = "Update!!!"
      "Another" = "TAG!!!"
    }
}

resource "aws_vpc" "newVpc" {
    provider = "terraform_test"
    cidr_block = "10.0.0.0/16"
}


resource "aws_key_pair" "instance-key" {
    key_name = "instance-key"
    region = "us-east-1"
    public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_security_group" "allowSSH" {
    name = "allow ssh"
    description = "allow ssh"
    vpc_id = aws_vpc.newVpc.id
    provider = "terraform_test"
    ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    description = "allow all out"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  
}