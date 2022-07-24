all: clean init pre_build ami post_build

pre_build: 
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.network \
	-target module.env.module.bastion_security_group \
	-target module.env.module.elasticache_security_group \
	-target module.env.module.efs_security_group \
	-target module.env.module.aurora_security_group \
	-target module.env.module.alb_security_group \
	-target module.env.module.launch_security_group \
	-target module.env.module.aurora_security_group_ingress_rule \
	-target module.env.module.bastion_security_group_ingress_rule \
	-target module.env.module.elasticache_security_group_ingress_rule \
	-target module.env.module.efs_security_group_ingress_rule \
	-target module.env.module.bastion_security_group_ingress_rule \
	-target module.env.module.alb_security_group_ingress_rule_http \
	-target module.env.module.alb_security_group_ingress_rule_https \
	-target module.env.module.launch_security_group_ingress_rule_ssh \
	-target module.env.module.launch_security_group_ingress_rule_http \
	-target module.env.module.efs \
	-target module.env.module.elasticache \
	-target module.env.module.aurora \
	-target module.env.local_file.ansible_vars \
	--auto-approve && cd -

post_build: 
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.ec2-bastion \
	-target module.env.module.alb \
	-target module.env.module.cdn_route53_record \
	-target module.env.module.main_site_route53_record \
	-target module.env.module.main_site_redirect_wwww_route53_record \
	-target module.env.module.autoscale \
	-target module.env.module.iam \
	-target module.env.module.s3 \
	-target module.env.module.cdn_acm \
	-target module.env.module.cdn_route53_acm \
	-target module.env.module.main_stie_route53_acm \
	-target module.env.module.main_site_acm \
	-target module.env.module.cloudfront \
	-target module.env.module.launch_config \
	--auto-approve && cd -

ami:
	cd ./packer/environment/${env} && \
	PACKER_LOG=1 packer build -var-file=${env}.variables.${type} bastion.${type} && \
	PACKER_LOG=1 packer build -var-file=${env}.variables.${type} app.${type} && cd - \

init:
	cd ./terraform/environment/${env} && terraform init && cd -

plan:
	cd ./terraform/environment/${env} && terraform plan -var-file ${env}_env.tfvars && cd -

list_state:
	cd ./terraform/environment/${env} && terraform state list cd -

sg:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.bastion_security_group \
	-target module.env.module.bastion_security_group \
	-target module.env.module.elasticache_security_group \
	-target module.env.module.efs_security_group \
	-target module.env.module.aurora_security_group \
	-target module.env.module.alb_security_group \
	-target module.env.module.launch_security_group \
	-target module.env.module.aurora_security_group_ingress_rule \
	-target module.env.module.bastion_security_group_ingress_rule \
	-target module.env.module.elasticache_security_group_ingress_rule \
	-target module.env.module.efs_security_group_ingress_rule \
	-target module.env.module.bastion_security_group_ingress_rule \
	-target module.env.module.alb_security_group_ingress_rule_http \
	-target module.env.module.alb_security_group_ingress_rule_https \
	-target module.env.module.launch_security_group_ingress_rule_ssh \
	-target module.env.module.launch_security_group_ingress_rule_http \
	--auto-approve && cd -

alb:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.alb \
	--auto-approve && cd -

launch_config:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.launch_config \
	--auto-approve && cd -

acm:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.acm \
	--auto-approve && cd -

route53:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.route53 \
	--auto-approve && cd -

autoscale:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.autoscale \
	--auto-approve && cd -

bastion:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.ec2-bastion \
	--auto-approve && cd -

network:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.network \
	--auto-approve && cd -

aurora:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.aurora \
	--auto-approve && cd -

elasticache:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.elasticache \
	--auto-approve && cd -

efs:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.efs \
	--auto-approve && cd -

ansible_vars:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.local_file.ansible_vars \
	--auto-approve && cd -

iam:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.iam \
	--auto-approve && cd -

s3_cloudfront:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.s3_cloudfront \
	--auto-approve && cd -

main_site_cloudfront:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.main_site_cloudfront \
	--auto-approve && cd -

s3_with_cdn: 
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.s3 \
	-target module.env.module.s3_cloudfront \
	--auto-approve && cd -

remove_public_ip:
	cd ./terraform/environment/${env}/modules/network &&\
	sed -i '19,22 s/^/#/' private_subnets.tf && cd -

clean:
	cd ./terraform/environment/stg && rm -rf \
	.terraform \
	*.tfstate \
	*.hcl \
	*.info \
	*.backup *. \
	.terraform.lock.hcl \
	.terraform.tfstate.lock.info \
	&& cd - 
