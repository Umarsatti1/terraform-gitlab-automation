output "public_ip_address" {
    value = aws_instance.my_ec2_instance[*].public_ip
}

output "public_dns_name" {
    value = aws_instance.my_ec2_instance[*].public_dns
}

output "private_ip_address" {
    value = aws_instance.my_ec2_instance[*].private_ip
}