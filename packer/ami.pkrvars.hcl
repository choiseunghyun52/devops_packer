ami_name        = "devops-ami"
ami_description = "devops-ami"

instance_type    = "t3.micro"
ssh_keypair_name = "prod"
ssh_username     = "ec2-user"

Region      = "ap-northeast-2"
Environment = "prod"
Owner       = "dj.kim"
IMDSv2      = "false"

playbook_file = "playbook.yaml"
//kms_key_id    = "{KMS_KEY_ID}"

ami_users = []
