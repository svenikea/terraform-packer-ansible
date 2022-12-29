data "aws_availability_zones" "filtered_zones" {
    state           = "available"
    exclude_names   = ["${var.region}-atl-1a","${var.region}-bos-1a","${var.region}-mia-1a"]
}