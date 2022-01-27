run:
	packer build -var-file="./packer/ami.pkrvars.hcl" ./packer

validate:
	packer validate -var-file="./packer/ami.pkrvars.hcl" ./packer