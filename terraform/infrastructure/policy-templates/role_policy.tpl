{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com",
                "AWS": "${user_arn}"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
