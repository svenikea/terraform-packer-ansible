# network_layer
module "network_layer" {
    source                  = "./modules/network_layer"
    project                 = var.project 
    environment             = var.environment
    vpc_cidr_block          = var.vpc_cidr_block
    public_subnet_number    = var.public_subnet_number
    public_cidr_blocks      = var.public_cidr_blocks
    private_subnet_number   = var.private_subnet_number
    private_cidr_blocks     = var.private_cidr_blocks
}

# route_layer
# module "route_layer" {
#     source    = "./modules/route_layer"
#     igw_id    = module.network_layer.igw_id
#     subnet_id = [
#         module.network_layer.public_subnet_1a,
#         module.network_layer.public_subnet_1b
#     ]
#     vpc_id    = module.network_layer.vpc_id
# }

# # security_layer 
# module "security_layer" {
#     source = "./modules/security_layer"
#     vpc_id = module.network_layer.vpc_id
# }

# # web_layer
# module "web_layer" {
#     source              = "./modules/web_layer"
#     ec2_sg_id           = module.security_layer.ec2_sg_id
#     vpc_id              = module.network_layer.vpc_id
#     subnet_id           = [
#         module.network_layer.public_subnet_1a,
#         module.network_layer.public_subnet_1b
#     ]
#     elb_sg_id           = module.security_layer.elb_sg_id
#     instance_name       = var.instance_names
#     instance_type       = var.instance_type
#     alb_name            = var.alb_name
#     min_scale_size      = var.min_scale_size
#     max_scale_size      = var.max_scale_size
# }