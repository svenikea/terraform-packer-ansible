all: clean ami remote_state master_resource

remote_state:
	cd terraform/environment && terragrunt run-all init --terragrunt-include-dir "backend" && terragrunt run-all apply --terragrunt-include-dir "backend" && cd -

master_resource:
	cd terraform/environment && terragrunt run-all init --terragrunt-include-dir "shared_resource" && terragrunt run-all apply --terragrunt-include-dir "shared_resource" && cd -

plan_master_resource:
	cd terraform/environment && terragrunt run-all init --terragrunt-include-dir "shared_resource" && terragrunt run-all plan --terragrunt-include-dir "shared_resource" && cd -

destroy_master_resource:
	cd terraform/environment && terragrunt run-all destroy --terragrunt-include-dir "shared_resource" && cd -

bastion_ami:
	cd ./packer/bastion && \
	packer build -var-file=variables.json bastion.json && cd -

backend_ami:
	cd ./packer/application && \
	packer build -var-file=variables.json application.json && cd -

ami: backend_ami bastion_ami

clean:
	find . -type f -name "*.tfstate" -or -name ".terraform" -or -name "backend.tf" -or -name "*.tfstate.backup" -or -name "*.lock.hcl" | xargs rm -rf

