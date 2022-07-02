resource "local_file" "ansible_vars" {
    filename    = "../../../ansible/group_vars/app_role/main.yml"
    content     = <<EOF
aurora_user: ${var.aurora_master_user}
aurora_password: ${module.aurora.aurora_password}
aurora_database: ${module.aurora.aurora_rds_cluster_database}
aurora_endpoint: ${module.aurora.aurora_rds_cluster_endpoint}
elasticache_endpoint: ${module.elasticache.elasticache_primary_endpoint}
efs_dns_name: ${module.efs.efs_dns_name}
s3_domain_name: ${jsonencode(split(",",(join(",",module.s3.web_static_domain_name))))}
iam_access_id: ${module.iam.iam_user_access_keys[1]}
iam_secret_access_key: ${module.iam.iam_user_secrets[1]}
route53_domain: ${var.route53_zone}
EOF 
}
