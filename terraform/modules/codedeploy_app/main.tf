resource "aws_codedeploy_app" "application" {
    name                = var.project
    compute_platform    = var.compute_platform
}
