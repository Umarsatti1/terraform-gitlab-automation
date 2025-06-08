# Create a Key pair
resource "aws_key_pair" "my_key_pair" {
    key_name = var.key_pair_name
    public_key = file("${var.key_pair_name}.pub")
}

# Create an EC2 instance
resource "aws_instance" "my_ec2_instance" {
    count = var.ec2_instance_count
    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key_pair ]

    ami = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    key_name = aws_key_pair.my_key_pair.key_name
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.my_security_group.id ]

    root_block_device {
      volume_size = var.root_volume_size
      volume_type = var.root_volume_type
    }

    tags = {
        Name = var.ec2_instance_name
    }
}

