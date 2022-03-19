# Architecture 
!["architect"](./images/wordpress-on-aws.png)

# Deploy procedure
* ### Step 1
Deploy Networking and database 

* ### Step 2
Build AMI with packer

* ### Step 3
Deploy EC2, ALB and Autoscale 

# Terraform commands
## Apply a specific target 

```bash
terraform apply -target RESOURCE_TYPE.RESOURCE_NAME --auto-approve
```

## Destroy a specific target 

```bash
terraform destroy -target RESOURCE_TYPE.RESOURCE_NAME --auto-approve
```

## Show All state 

```bash
terraform state list
```

## Show a specific state

```bash
terraform state show RESOURCE_TYPE.RESOURCE_NAME
```

