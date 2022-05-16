output "elasticache_primary_endpoint" {
    value = aws_elasticache_replication_group.elasticache_replica_group.primary_endpoint_address
}

output "elasticache_reader_endpoint" {
    value = aws_elasticache_replication_group.elasticache_replica_group.reader_endpoint_address
}
