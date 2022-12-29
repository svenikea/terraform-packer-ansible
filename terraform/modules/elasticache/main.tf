resource "aws_elasticache_cluster" "project_elasticache" {
    cluster_id                              = "${var.project}-memcache-${var.env}"
    engine                                  = var.node_engine
    engine_version                          = var.node_version
    node_type                               = var.node_type
    num_cache_nodes                         = var.num_cache_nodes
    az_mode                                 = var.az_mode
    parameter_group_name                    = aws_elasticache_parameter_group.custom_paragroup.name
    port                                    = 11211
    #preferred_availability_zones            = random_shuffle.az.result
    security_group_ids                      = var.elasticache_sg
    subnet_group_name                       = aws_elasticache_subnet_group.elasticache_subnet.name
}

# resource "random_shuffle" "az" {
#   input                                     = data.aws_availability_zones.filtered_zones.names
#   result_count                              = var.num_cache_nodes
# }

resource "aws_elasticache_parameter_group" "custom_paragroup" {
    name                                    = "${var.project}-parameter-group-${var.env}"
    family                                  = var.node_family
    dynamic "parameter" {
        for_each                            = var.memcache_parameter_group
        content {
            name                            = parameter.value.name
            value                           = parameter.value.value
        }
    }
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
    name                                    = "${var.project}-elasticache-subnet-${var.env}"
    subnet_ids                              = var.private_subnets
}
