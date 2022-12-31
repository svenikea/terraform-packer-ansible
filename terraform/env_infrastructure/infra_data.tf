data "aws_vpc" "vpc_data" {
  filter {
    name                        = "tag:Name" 
    values                      = ["*${var.project}*"]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name                        = "vpc-id"
    values                      = [data.aws_vpc.vpc_data.id]
  }  
  tags = {
      Tier                      = "Private"
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name                        = "vpc-id"
    values                      = [data.aws_vpc.vpc_data.id]
  }  
  tags = {
      Tier                      = "Private"
  }
}

data "aws_s3_bucket" "shared_bucket" {
  bucket = "${var.project}-wordpress-storage-shared"
}

data "aws_acm_certificate" "issued" {
  domain   = "${var.issued_domain}"
  statuses = ["ISSUED"]
}

data "aws_security_groups" "bastion_security_group" {
    filter {
      name                  = "tag:Name"
      values                = ["*-bastion*"]
    }           
}

data "aws_ami" "app_instance_data"{
    most_recent                 = true
    #owners                      = ["self"]
    owners                      = ["amazon"]
    filter {
        name                    = "name"
        #values                  = ["app-ami-gold"]
        values                  = ["amzn2-ami-hvm-*"]
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
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_iam_policy_document" "launch_template_policy" {
  version = "2012-10-17"
  statement {
    sid = "BucketWritePolicy"
    effect = "Allow"
    actions = [
        "s3:PutObject",
        "s3:DeleteObject"
    ]
    resources = ["arn:${data.aws_partition.current.id}:s3:::*"]
  }
  statement {
    sid = "CloudfrontPolicy"
    effect = "Allow"
    actions = [
        "cloudfront:List*"
    ]
    resources = ["*"]
  }
  statement {
    sid = "ListBUcketsPolicy"
    effect = "Allow"
    actions = [
        "s3:List*",
        "s3-object-lambda:Get*",
        "s3-object-lambda:List*",
        "s3:Get*"
    ]
    resources =  ["*"]
  }
  statement {
    sid = "ChangeBucketPolicy"
    effect = "Allow"
    actions = [
      "s3:PutAccessPointPolicyForObjectLambda",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutMultiRegionAccessPointPolicy",
      "s3:DeleteBucketPolicy",
      "s3:BypassGovernanceRetention",
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:DeleteAccessPointPolicyForObjectLambda",
      "s3:PutObjectVersionAcl",
      "s3:PutBucketAcl",
      "s3:PutBucketPolicy",
      "s3:DeleteAccessPointPolicy",
      "s3:PutAccessPointPolicy",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:${data.aws_partition.current.id}:s3:::*"]
    }
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeVolumes",
      "ec2:DescribeTags",
      "ec2:CreateTags",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:CreateLogGroup"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
        "ssm:GetParameter"
    ]
    resources = ["arn:${data.aws_partition.current.id}:ssm:*:*:parameter/AmazonCloudWatch-*"]
  }
  statement {
    effect = "Allow"
    actions = [
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
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "launch_template_role" {
  statement {
    actions         = ["sts:AssumeRole"]
    principals {
      type          = "Service"
      identifiers   = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_route53_zone" "current_zone" {
  name         = "${var.project_domain}"
  private_zone = false
}