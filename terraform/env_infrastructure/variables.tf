variable "project" {}
variable "region" {}
variable "env" {}

variable "node_family" {}
variable "node_engine" {}
variable "node_version" {}
variable "node_type" {}
variable "az_mode" {}
variable "num_cache_nodes" {}
variable "memcache_parameter_group" {}
variable "project_domain" {}
variable "project_sub_domain" { default = null }
variable "new_acm" {}
variable "route53_enable" {}

variable "key_name" {}            
variable "instance_type" {}       
variable "volume_size" {}     
variable "volume_type" {}     
variable "delete_on_termination" {}  
variable "encrypted" {}        
variable "iops" {}        

variable "autoscale_tags" {}
variable "autoscale_min_scale_size" {}
variable "autoscale_max_scale_size" {}
variable "autoscale_termination_policy" {}
variable "autoscale_health_check_type" {}
variable "autoscale_health_check_grace_period" {}
variable "autoscale_target_policy" {}
variable "loadbalance_cpu_target" {}
variable "issued_domain" {}