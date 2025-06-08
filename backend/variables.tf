variable "s3_bucket_name" {
    default = "terraform-gitlab-automation-bucket"
    description = "This is the name of the S3 bucket"
    type = string
}

variable "dynamodb_table_name" {
    default = "terraform-gitlab-automation-dynamodb-table"
    description = "This is the name of the DynamoDB table"
    type = string
}