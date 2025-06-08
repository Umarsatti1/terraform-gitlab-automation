output "s3_bucket_name" {
    value = aws_s3_bucket.remote_s3.bucket
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_state_lock.name
}