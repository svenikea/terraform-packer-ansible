{
    "Version": "2012-10-17",
    "Statement": [
        %{ if iam_user != "bastion_user" }
        {
            "Sid": "BcketWritePolicy",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource" : ${jsonencode(concat(split(",",top_bucket_arns),split(",",sub_bucket_arns)))}
        },
        {
            "Sid": "CloudfrontPolicy",
            "Effect": "Allow",
            "Action": [
                "cloudfront:List*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ListBUcketsPolicy",
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*",
                "s3:Get*"
            ],
            "Resource" : "*"

        },
        {
            "Sid": "ChangeBucketPolicy",
            "Effect": "Allow",
            "Action": [
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
            ],
            "Resource": ${jsonencode(split(",",top_bucket_arns))}
        },
        %{ endif }
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeVolumes",
                "ec2:DescribeTags",
                "ec2:CreateTags",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
        },
        {
            "Effect": "Allow",
            "Action": [
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
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
