resource "aws_s3_object" "object_key" {
    bucket                  = var.bucket_id
    key                     = var.object_key
    content_type            = "application/x-directory"
}