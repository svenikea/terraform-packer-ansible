module "shared_wordpress_storage" {
    source                  = "../modules/s3"
    bucket_names            = "${var.project}-wordpress-storage"
    project                 = var.project
    env                     = var.env
    object_key              = "uploads"
    bucket_policy           = data.aws_iam_policy_document.s3_bucket_policy.json
}

module "cloudfront_oai" {
    source                  = "../modules/cloudfront_oai"
    oai_comment             = "Allow Access to S3"
}