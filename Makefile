all: init pre_build ami post_buid

pre_build: network sg efs s3 iam aurora elasticache

post_build: bastion alb autoscale launch_config

ami:
	cd ./packer && packer build \
	-var-file=variables.json bastion.json && \
	packer build -var-file=variables.json app.json && cd -

init:
	cd ./terraform/environment/${env} && terraform init && cd -

${state}:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars && cd -

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

s3_policy:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.s3_bucket_policy \
	--auto-approve && cd -

iam:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.iam \
	-target module.env.module.s3 \
	--auto-approve && cd -

cloudfront:
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.cloudfront \
	--auto-approve && cd -

s3: 
	cd ./terraform/environment/${env} && terraform ${state} -var-file ${env}_env.tfvars \
	-target module.env.module.s3 \
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
