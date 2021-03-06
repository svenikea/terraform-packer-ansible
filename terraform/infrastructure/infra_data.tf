data "aws_ami" "bastion_instance_data"{
    most_recent                 = true
    owners                      = ["self"]
    filter {
        name                    = "name"
        values                  = ["bastion-*"]
    }
    filter {
        name                    = "architecture"
        values                  = ["x86_64"]
    }
    filter {
        name                    = "virtualization-type"
        values                  = ["hvm"]
    }
    filter {
        name                    = "hypervisor"
        values                  = ["xen"]
    }
    filter {
        name                    = "image-type"
        values                  = ["machine"]
    }
}

data "template_file" "role_policy_template" {
    count               = var.iam_users != null ? length(var.iam_users) : 0
    template            = file("${path.module}/policy-templates/iam_policy.tpl")
    vars = {
        top_bucket_arns = "${join(",",module.s3.bucket_arns)}"
        sub_bucket_arns = "${join("/*,",module.s3.bucket_arns)}/*"
        iam_user        = "${element(var.iam_users,count.index)}"
        region          = var.region
        account_id      = var.account_id
    }
}

data "template_file" "iam_policy_template" {
    count               = var.iam_users != null ? length(var.iam_users) : 0
    template            = file("${path.module}/policy-templates/role_policy.tpl")
    vars = {
        user_arn        = "${module.iam.iam_user_arns[count.index]}"
    }
}

data "template_file" "s3_bucket_policy_template" {
    template            = file("${path.module}/policy-templates/cloudfront_to_s3_policy.tpl")
    vars = {
        top_bucket_arns = "${module.s3.static_bucket_arn}"
        sub_bucket_arns = "${module.s3.static_bucket_arn}/*"
        cloudfront_arn  = "${module.cloudfront.cloudfront_origin_identity_arn}"
    }
}

data "aws_ami" "launch_ami_data"{
    most_recent                             = true
    owners                                  = ["self"]
    filter {
        name                                = "name"
        values                              = ["app-*"]
    }
    filter {
        name                                = "architecture"
        values                              = ["x86_64"]
    }
    filter {
        name                                = "virtualization-type"
        values                              = ["hvm"]
    }
    filter {
        name                                = "hypervisor"
        values                              = ["xen"]
    }
    filter {
        name                                = "image-type"
        values                              = ["machine"]
    }
}

data "aws_route53_zone" "current_zone" {
  name         = "${var.route53_zone}"
  private_zone = false
}
