{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": ${jsonencode(concat(split(",",top_bucket_arns),split(",",sub_bucket_arns)))}
            "Principal": {
                "AWS": "${cloudfront_arn}"
            },
            "Action": "s3:GetObbject"
        }
    ]
}
