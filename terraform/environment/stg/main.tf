module "env" {
    source                                      = "../../env_infrastructure"

    project                                     = var.project
    env                                         = "stg"
    node_family                                 = "memcached1.6"
    node_engine                                 = "memcached"
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
}
