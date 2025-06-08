resource "dynamodb_table" "terraform_state_lock" {
    name = var.dynamodb_table_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID" # Lock ID
        type = "S" # String
    }

    tags = {
        Name = var.dynamodb_table_name
    }

}