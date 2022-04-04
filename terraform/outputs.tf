# RDS LAYER
output "aurora_user" {
    value = var.aurora_user
}
output "aurora_password" {
    value = module.database_layer.aurora_password
}

output "aurora_rds_database" {
    value = module.database_layer.aurora_rds_cluster_database
}

output "aurora_rds_cluster_endpoint" {
    value = module.database_layer.aurora_rds_cluster_endpoint
}

# S3 LAYER
output "s3_domain_name" {
    value = module.storage_layer.web_static_domain_name
}

output "bucket_arns" {
    value = module.storage_layer.bucket_arns
}


# FRONTEND LAYER
output "frontent_lb_dns_name" {
    value = module.front_layer.load_balance_dns
}
resource "local_file" "ansible_vars" {
    filename    = "../ansible/app/group_vars/app_role/main.yml"
    content     = <<EOF
aurora_user: ${var.aurora_user}
aurora_password: ${module.database_layer.aurora_password}
aurora_database: ${module.database_layer.aurora_rds_cluster_database}
aurora_endpoint: ${module.database_layer.aurora_rds_cluster_endpoint}
elasticache_endpoint: ${module.cache_layer.elasticache_primary_endpoint}
s3_domain_name: ${jsonencode(split(",",(join(",",module.storage_layer.web_static_domain_name))))}
efs_dns_name: ${module.efs_layer.efs_dns_name}
iam_access_id: ***REMOVED***
iam_secret_access_key: ***REMOVED***
EOF 
}

# EFS LAYER
output "efs_mount_target_dns_name" {
    value = module.efs_layer.efs_mount_target_dns_name
}

