all: init apply_a ami apply_b

ami:
	cd ./packer && packer build -var-file=variables.json bastion.json && packer build -var-file=variables.json app.json && cd -

init:
	cd ./terraform && terraform init 

plan:
	cd ./terraform && terraform plan && cd -

apply_a:
	cd ./terraform && terraform apply -target module.network_layer -target module.database_layer -target local_file.ansible_vars --auto-approve && cd -

apply_b:
	cd ./terraform && terraform apply -target module.front_layer -target module.app_layer --auto-approve && cd -

destroy:
	cd ./terraform && terraform destroy --auto-approve && cd -

clean:
	cd ./terraform && rm -rf ./.terraform *.tfstate *.hcl *.info *.backup *. .terraform.lock.hcl && cd -