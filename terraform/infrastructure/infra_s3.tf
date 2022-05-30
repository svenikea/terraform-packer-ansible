module "s3" {
    source          = "../modules/s3"

    project         = var.project
    env             = var.env
    region          = var.region

    bucket_names    = var.bucket_names 
    vpc_id          = module.network.vpc_id
    s3_versioning   = var.s3_versioning
    bucket_policy   = data.template_file.s3_bucket_policy_template.rendered
}
