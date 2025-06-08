resource "aws_s3_bucket" "remote_s3" {
    bucket = var.bucket_name
    force_destroy = true

    tags = {
        Name = var.bucket_name
    }
}