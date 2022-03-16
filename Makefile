init:
	cd ./terraform && terraform init 

apply:
	cd ./terraform && terraform apply --auto-approve && cd -

destroy:
	cd ./terraform && terraform destroy --auto-approve && cd -

plan:
	cd ./terraform && terraform plan && cd -

build-ami:
	cd ./packer && packer build bastion.pkr.hcl

clean:
	cd ./terraform && rm -rf ./.terraform *.tfstate *.hcl *.info *.backup *. .terraform.lock.hcl && cd -