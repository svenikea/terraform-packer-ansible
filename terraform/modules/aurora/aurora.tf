resource "aws_rds_cluster" "aurora_cluster" {
    cluster_identifier      = "aurora-cluster-${var.project}-${var.env}"
    engine                  = "aurora-${var.aurora_engine}"
    engine_version          = var.aurora_engine_version
    master_username         = var.aurora_user
    master_password         = random_string.aurora_password.result
    database_name           = var.aurora_database_name
    vpc_security_group_ids  = [var.aurora_sg]
    db_subnet_group_name    = aws_db_subnet_group.aurora_subnet.id
    skip_final_snapshot     = true
    backup_retention_period = var.backup_retention_period
    apply_immediately       = true
}

resource "aws_rds_cluster_instance" "aurora_instance" {
    count                   = var.aurora_instance_number
    identifier              = "${var.project}-aurora-${var.env}-${count.index+1}"
    cluster_identifier      = aws_rds_cluster.aurora_cluster.id
    instance_class          = "db.${var.aurora_instance_class}"
    engine                  = aws_rds_cluster.aurora_cluster.engine
    engine_version          = aws_rds_cluster.aurora_cluster.engine_version
    db_parameter_group_name = aws_db_parameter_group.aurora_parameter_group.name
    apply_immediately       = true
}

resource "aws_db_subnet_group" "aurora_subnet" {
    name                    = "${var.project}-aurora-subnet-group-${var.env}"
    subnet_ids              = var.private_subnets
    tags = {
        Name                = "${var.project}-aurora-subnet-group-${var.env}"
    }
}

resource "random_string" "aurora_password" {
    length                  = var.random_string_length
    special                 = false
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
    name                    = "${var.project}-aurora-pg-${var.env}"
    family                  = "aurora-${var.aurora_engine}5.7"
    dynamic "parameter" {
        for_each            = var.aurora_parameter_group
        content {
            name            = parameter.value.name
            value           = parameter.value.value 
        }
    }
}
