module "env" {
    source                                      = "../../env_infrastructure"

    project                                     = var.project
    region                                      = var.region
    env                                         = "stg"
    node_family                                 = "memcached1.6"
    node_engine                                 = "memcached"
    az_mode                                     = "cross-az"
    node_version                                = "1.6.12"
    node_type                                   = "cache.t3.small"
    num_cache_nodes                             = 2
    memcache_parameter_group                    = [
        {
            name    = "chunk_size"
            value   = "512"
        },
        {
            name    = "worker_logbuf_size"
            value   = "128"
        }
    ]

    route53_enable                              = true
    project_domain                              = var.project_domain
    new_acm                                     = true
    project_sub_domain                          = "stg"
    
    key_name                                    = "${var.project}-shared"
    instance_type                               = "t2.micro"  
    volume_size                                 = "20"
    volume_type                                 = "gp3"
    delete_on_termination                       = true
    encrypted                                   = true
    iops                                        = "3000"

    autoscale_min_scale_size                    = 2
    autoscale_max_scale_size                    = 4
    autoscale_termination_policy                = "NewestInstance"
    autoscale_target_policy                     = "ASGAverageCPUUtilization"
    autoscale_health_check_type                 = "ELB"
    loadbalance_cpu_target                      = 40.0
    autoscale_health_check_grace_period         = 300
    autoscale_tags                              = [
        {
            key                                 = "ServerType"
            value                               = "Backend"
        },
        {
            key                                 = "Environment"
            value                               = "stg"
        }
    ]

    issued_domain                               = "stg.${var.project_domain}"

    efs_performance_mode                        = "generalPurpose"
    efs_throughput_mode                         = "bursting"
}
