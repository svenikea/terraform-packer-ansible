project                             = "wordpress"
env                                 = "stg"
region                              = "us-east-1"

vpc_cidr_block                      = "10.0.0.0/16"
public_subnets                      = ["10.0.1.0/24","10.0.2.0/24"]
private_subnets                     = ["10.0.3.0/24","10.0.4.0/24"]

ec2_instance_connect_ip_prefix      = "18.206.107.24/29"

instance_type                       = "t2.micro"
keyname                             = "aws-key"
volume_size                         = 30
volume_type                         = "gp3"
iops                                = 3000

efs_performance_mode                = "generalPurpose"
efs_throughput_mode                 = "bursting"

elasticache_cluster_number          = 2
node_class                          = "t3.small"
cache_engine                        = "redis"
cache_version                       = "6.x"
cache_family                        = "redis6.x"
elasticache_parameter_group         = [
    {
        name    = "activedefrag"
        value   = "yes"
    },
    {
        name    = "activerehashing"
        value   = "yes"
    },
    {
        name    = "cluster-enabled"
        value   = "no"
    }
]
autoscale_min_scale_size            = 2
autoscale_max_scale_size            = 4
autoscale_termination_policy        = "NewestInstance"
autoscale_target_policy             = "ASGAverageCPUUtilization"
autoscale_health_check_type         = "ELB"
alb_cpu_target                      = 40.0
autoscale_health_check_grace_period = 300

aurora_instance_number              = 2
aurora_backup_retention_period      = 1
aurora_instance_class               = "t3.small"
aurora_engine                       = "mysql"
aurora_engine_version               = "5.7.12"
aurora_random_string_length         = 12
aurora_master_user                  = "admin"
aurora_database_name                = "aurora"
aurora_parameter_group  = [
    {
        name    = "log_output"
        value   = "FILE"
    },
    {
        name    = "log_warnings"
        value   = "2"
    },
    {
        name    = "slow_query_log"
        value   = "1"
    },
    {
        name    = "log_queries_not_using_indexes"
        value   = "1"
    },
    {
        name    = "long_query_time"
        value   = "5"
    },
    {
        name    = "general_log"
        value   = "1"
    },
    {
        name    = "innodb_lock_wait_timeout"
        value   = "50"
    }
]

route53_domain                      = "cmcloudlab1777.info"
