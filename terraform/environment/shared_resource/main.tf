module "shared_resource" {
    source              = "../../shared_infrastructure"
    project             = var.project
    region              = var.region
    public_ip           = var.public_ip
}