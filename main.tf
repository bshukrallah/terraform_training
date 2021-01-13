resource "aws_instance" "my_first_server" {
    ami = "ami-0be2609ba883822ec"
    provider = aws.terraformTest
    instance_type = "t2.micro"
    key_name = aws_key_pair.instance-key.key_name
        associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.allowSSH.id]
    tags = {
      "Name" = "VM_TF"
    }
}

resource "aws_vpc" "newVpc" {
    provider = aws.terraformTest
    cidr_block = "10.0.0.0/16"
}


resource "aws_key_pair" "instance-key" {
    key_name = "instance-key"
    provider = aws.terraformTest
    public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_availability_zones" "azs" {
        provider = aws.terraformTest
        state = "available"
}

resource "aws_subnet" "subnet-tf" {
        provider = aws.terraformTest
        availability_zone = element(data.aws_availability_zones.azs.names, 0)
        vpc_id = aws_vpc.newVpc.id
        cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "allowSSH" {
    name = "allow ssh"
    description = "allow ssh"
    vpc_id = aws_vpc.newVpc.id
    provider = aws.terraformTest
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