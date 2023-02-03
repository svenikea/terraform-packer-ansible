data "aws_subnets" "public_subnets" {
  filter {
    name                        = "vpc-id"
    values                      = [data.aws_vpc.vpc_data.id]
  }  
  tags = {
      Tier                      = "Public"
  }
}

data "aws_vpc" "vpc_data" {
  filter {
    name                        = "tag:Name" 
    values                      = ["${var.project}-vpc"]
  }
  depends_on                    = [module.network]
}

data "aws_ip_ranges" "service_ip" {
    regions                     = ["${var.region}"]
    services                    = ["ec2_instance_connect"] 
}

data "aws_ami" "bastion_instance_data"{
    most_recent                 = true
    owners                      = ["self"]
    #owners                      = ["amazon"]
    filter {
        name                    = "name"
        values                  = ["bastion-ami-gold"]
        #values                  = ["amzn2-ami-hvm-*"]
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

data "aws_iam_policy_document" "s3_bucket_policy" {
  version                       = "2012-10-17"
  statement {
    principals {
      type                      = "AWS"
      identifiers               = ["${module.cloudfront_oai.oai_arn}"]
    }
    actions                     = ["s3:GetObject"]
    resources                   = [
      "${module.shared_wordpress_storage.bucket_arn}",
      "${module.shared_wordpress_storage.bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "bastion_policy" {
    statement {
    sid           = "ParameterPolicy"
    effect        = "Allow"
    actions       = [
      "ssm:GetParameter"
    ]
    resources     = [
      "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
    ]
  }
  statement {
    effect        = "Allow"
    actions       = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation"   
    ]
    resources    = ["*"]
  }
  statement {
    effect       = "Allow"
    actions      = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources    = ["*"]
  }
  statement {
    effect       =  "Allow"
    actions      = [
        "ec2messages:AcknowledgeMessage",
        "ec2messages:DeleteMessage",
        "ec2messages:FailMessage",
        "ec2messages:GetEndpoint",
        "ec2messages:GetMessages",
        "ec2messages:SendReply"
    ]
    resources    = ["*"]
  }
}

data "aws_iam_policy_document" "bastion_role" {
  statement {
    actions         = ["sts:AssumeRole"]
    principals {
      type          = "Service"
      identifiers   = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_iam_policy_document" "devops_role_trust_entities" {
  statement {
    actions         = ["sts:AssumeRole"]
    principals {
      type          = "AWS"
      identifiers   = ["arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }  
    # condition {
    #   test          = "ForAnyValue:StringEquals"
    #   variable      = "aws:username"
    #   values        = var.devops_iam_users
    # }  
  }
}

data "aws_iam_policy_document" "devops_assume_role" {
  statement {
    actions         = ["sts:AssumeRole"]
    effect          = "Allow"
    resources       = ["arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:role/${var.project}-${var.env}-${var.devops_group_name}"]
  }
}

data "aws_iam_policy_document" "develop_assume_role" {
  statement {
    actions         = ["sts:AssumeRole"]
    effect          = "Allow"
    resources       = ["arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:role/${var.project}-${var.env}-${var.develop_group_name}"]
  }
}

data "aws_iam_policy_document" "develop_role_trust_entities" {
  statement {
    actions         = ["sts:AssumeRole"]
    principals {
      type          = "AWS"
      identifiers   = ["arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }  
    # condition {
    #   test          = "ForAnyValue:StringEquals"
    #   variable      = "aws:username"
    #   values        = var.develop_iam_users
    # }    
  }
}

data "aws_iam_policy_document" "develop_role_policy" {
  statement {
    sid             = "CodecommitPolicy"
    effect          = "Allow"
    actions         = [
      "codecommit:Merge*",
      "codecommit:Post*",
      "codecommit:Update*",
      "codecommit:Get*",          
      "codecommit:Test*",
      "codecommit:BatchGet*",
      "codecommit:GitPull",
      "codecommit:Create*",
      "codecommit:Put*",
      "codecommit:GitPush",
      "codecommit:Describe*",
      "codecommit:List*",
      "codecommit:DeleteBranch"
    ]
    resources = ["arn:${data.aws_partition.current.id}:codecommit:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}