output "oai_id" {
    value = module.cloudfront_oai.oai_id
}

output "oai_path" {
    value = module.cloudfront_oai.oai_path
}

output "oai_arn" {
    value = module.cloudfront_oai.oai_arn
}

output "private_subnet" {
    value = module.network.private_subnets
}

output "public_subnet" {
    value = module.network.public_subnets
}

# output "eip" {
#     value = module.network.eip[0]
# }

# output "route_public" {
#     value = module.network.public_route_table_id
# }

# output "route_private" {
#     value = module.network.private_route_table_id
# }