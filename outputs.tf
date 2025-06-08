output "public_ip_address" {
    value = aws_instance.my_ec2_instance[*].public_ip
}

output "public_dns_name" {
    value = aws_instance.my_ec2_instance[*].public_dns
}

output "private_ip_address" {
    value = aws_instance.my_ec2_instance[*].private_ip
}

output "s3_bucket_name" {
    value = aws_s3_bucket.remote_s3.bucket
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_state_lock.name
}