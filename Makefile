all: init apply_a ami apply_b

test_s3: 
	cd ./terraform && terraform apply -target module.storage_layer --auto-approve && cd -

destroy_s3: 
	cd ./terraform && terraform destroy -target module.storage_layer --auto-approve && cd -

test_iam:
	cd ./terraform && terraform apply -target module.iam_layer  -target module.storage_layer --auto-approve && cd -

destroy_iam:
	cd ./terraform && terraform destroy -target module.storage_layer -target module.iam_layer --auto-approve && cd -

test_cache:
	cd ./terraform && terraform apply -target module.network_layer -target module.security_layer -target module.cache_layer --auto-approve && cd -

destroy_cache:
	cd ./terraform && terraform destroy -target module.network_layer -target module.security_layer -target module.cache_layer --auto-approve && cd -

ami:
	cd ./packer && packer build -var-file=variables.json bastion.json && packer build -var-file=variables.json app.json && cd -

init:
	cd ./terraform && terraform init 

plan:
	cd ./terraform && terraform plan && cd -

apply_a:
	cd ./terraform && terraform apply -target module.network_layer -target module.security_layer -target module.database_layer -target local_file.ansible_vars -target module.cache_layer -target module.iam_layer -target module.storage_layer --auto-approve && cd -

apply_b:
	cd ./terraform && terraform apply -target module.front_layer -target module.app_layer --auto-approve && cd -

destroy_a:
	cd ./terraform && terraform destroy -target module.network_layer -target module.security_layer -target module.database_layer -target local_file.ansible_vars -target module.cache_layer -target module.iam_layer -target module.storage_layer --auto-approve && cd -

destroy_b:
	cd ./terraform && terraform destroy -target module.front_layer -target module.app_layer --auto-approve && cd -

destroy:
	cd ./terraform && terraform destroy --auto-approve && cd -

clean:
	cd ./terraform && rm -rf ./.terraform *.tfstate *.hcl *.info *.backup *. .terraform.lock.hcl .terraform.tfstate.lock.info && cd -