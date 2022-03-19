output "aurora_user" {
    value = var.aurora_user
}
output "aurora_password" {
    value = module.database_layer.aurora_password
}

output "aurora_rds_database" {
    value = module.database_layer.aurora_rds_cluster_database
}

# output "aurora_rds_instance_endpoint" {
#     value = module.database_layer.aurora_rds_instance_endpoint
# }

output "aurora_rds_cluster_endpoint" {
    value = module.database_layer.aurora_rds_cluster_endpoint
}

# output "vpc_id" {
#     value = module.network_layer.vpc_id
# }

# output "igw_id" {
#     value = module.network_layer.igw_id
# }

# output "private_subnets" {
#     value = module.network_layer.private_subnets
# }

# output "public_subnets" {
#     value = module.network_layer.public_subnets
# }

# output "nat_gateway_public_ip" {
#     value = module.network_layer.nat_gateway_public_ip
# }

# output "public_route_table_name" {
#     value = module.network_layer.public_route_table_name
# }

# output "private_route_table_name" {
#     value = module.network_layer.private_route_table_name
# }

# output "frontent_lb_dns_name" {
#     value = module.front_layer.load_balance_dns
# }

# output "app_lb_dns_name" {
#     value = module.app_layer.load_balance_dns
# }
resource "local_file" "ansible_vars" {
    filename    = "../ansible/app/group_vars/all/main.yml"
    content     = <<EOF
# Database
aurora_user: ${var.aurora_user}
aurora_password: ${module.database_layer.aurora_password}
aurora_database: ${module.database_layer.aurora_rds_cluster_database}
aurora_endpoint: ${module.database_layer.aurora_rds_cluster_endpoint}
app_name: "app"
sub_domain:
- mydomain.na
- mydomain.com
chosen_domain:  "{{ sub_domain[0] }}"
php_version: "php7.4"
                    EOF 
}