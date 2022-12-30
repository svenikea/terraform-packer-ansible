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
    
    key_name                                    = "${var.project}-shared"
    instance_type                               = "t2.micro"  
    volume_size                                 = "20"
    volume_type                                 = "gp2"
    delete_on_termination                       = true
    encrypted                                   = true
    iops                                        = "12000"
}
