ami:
	cd ./packer && packer build -var-file=variables.json bastion.json && packer build -var-file=variables.json app.json && cd -

init:
	cd ./terraform && terraform init 

plan:
	cd ./terraform && terraform plan && cd -

apply:
	cd ./terraform && terraform apply --auto-approve && cd -

destroy:
	cd ./terraform && terraform destroy --auto-approve && cd -

clean:
	cd ./terraform && rm -rf ./.terraform *.tfstate *.hcl *.info *.backup *. .terraform.lock.hcl && cd -