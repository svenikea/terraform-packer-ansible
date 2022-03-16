data "aws_ami" "webserver_instance_data"{
    most_recent = true
    owners      = ["amazon"]
    filter {
        name    = "name"
        values  = ["amzn2-ami-*"]
    }
    filter {
        name    = "architecture"
        values  = ["x86_64"]
    }
    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }
    filter {
        name    = "hypervisor"
        values  = ["xen"]
    }
    filter {
        name    = "image-type"
        values  = ["machine"]
    }
    filter {
        name    = "block-device-mapping.volume-type"
        values  = ["gp2"]
    }
}

