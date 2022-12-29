generate "backend" {
  path      = "../../../${path_relative_to_include()}/backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.backend_s3}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "${local.backend_dynamodb}"
  }
}
EOF
}

locals {
    region              = "us-east-1"
    backend_dynamodb    = "terraform-app-state-locks"
    random_number       = "87498723999"
    backend_s3          = "terraform-state-${local.random_number}"
    project             = ""
    project_domain      = ""
}

inputs = {
    project             = "${local.project}"
    region              = "${local.region}"
    backend_s3          = "${local.backend_s3}"
    backend_dynamodb    = "${local.backend_dynamodb}"
    project_domain      = "${local.project_domain}"
    develop_iam_users   = ["developer_1", "developer_2"]
    devops_iam_users    = ["devops_1", "devops_2"]
    develop_group_name  = "develops"
    devops_group_name   = "devops"
    public_ip           = run_cmd("/usr/bin/dig", "+short", "myip.opendns.com", "@resolver1.opendns.com")       # <= For Mac/Linux Users
    #public_ip           = trim(run_cmd("dig", "+short", "myip.opendns.com", "@resolver1.opendns.com"), "\r")   # <= For Windows Users
}