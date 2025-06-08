variable "ec2_instance_ami" {
    default = "ami-0f9de6e2d2f067fca"
    description = "This the AMI ID of the instance(s)"
    type = string
}

variable "ec2_instance_count" {
    default = 1
    description = "This is the number instance(s)"
    type = number
}

variable "ec2_instance_type" {
    default = "t2.micro"
    description = "This the type of EC2 instance"
    type = string
}

variable "ec2_instance_name" {
    default = "python-terraform-ec2-instance"
    description = "This is the name of the EC2 instance"
    type = string
}

variable "key_pair_name" {
    default = "tf-key-pair"
    description = "This is the name of the key pair"
    type = string
}

variable "sg_name" {
    default = "python-terraform-sg"
    description = "This is the name of the security group"
    type = string
}

variable "availability_zone" {
    default = "us-east-1f"
    description = "This is the us-east-1f availability zone"
    type = string
}

variable "root_volume_size" {
    default = 10
    description = "This is the root volume size"
    type = number
}

variable "root_volume_type" {
    default = "gp2"
    description = "This is the root volume type"
    type = string
}