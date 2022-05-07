resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id              = var.vpc_id
    service_name        = "com.amazonaws.${var.region}.s3"
    vpc_endpoint_type   = "Gateway"
    tags = {
        Name            = "${var.project}-S3-Endpoint-${var.env}"
    }
}