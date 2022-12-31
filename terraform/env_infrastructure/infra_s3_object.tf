module "s3_object_key" {
    source          = "../modules/s3_object_key"
    bucket_id       = data.aws_s3_bucket.shared_bucket.id
    object_key      = "${var.env}/"
}