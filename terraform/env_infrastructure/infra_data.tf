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

data "aws_security_groups" "bastion_security_group" {
    filter {
      name                  = "tag:Name"
      values                = ["*-bastion*"]
    }           
}
