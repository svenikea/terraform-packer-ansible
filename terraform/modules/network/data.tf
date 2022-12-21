data "aws_iam_policy_document" "vpc_policy" {
  policy_id       = "Policy1670295277677"
  version         = "2012-10-17"
  statement {
    sid           = "Stmt1670295275876"
    actions       = ["*"]
    effect        = "Allow"
    resources     = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"] 
    } 
  }
}

data "aws_availability_zones" "filtered_zones" {
    state           = "available"
    exclude_names   = ["${var.region}-atl-1a","${var.region}-bos-1a"]
}