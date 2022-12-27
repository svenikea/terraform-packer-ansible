resource "aws_security_group" "security_group_name" {
    vpc_id          = var.vpc_id
    name_prefix     = "${var.project}-${var.sg_name}-${var.env}"
    description     = var.sg_name

    tags = {
        Name        = "${var.project}-${var.sg_name}"
        Env         = var.env
        Terraform   = true
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    timeouts {
      create            = "1m"
      delete            = "2m"
    }       
    lifecycle {
        create_before_destroy = true
    }
}
