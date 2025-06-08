resource "aws_s3_bucket" "remote_s3" {
    bucket = var.s3_bucket_name
    force_destroy = true

    tags = {
        Name = var.s3_bucket_name
    }
}